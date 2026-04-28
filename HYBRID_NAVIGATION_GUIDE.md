# Hybrid Navigation Architecture Guide

## Overview

The app now uses a **hybrid approach** combining:
- **GoRouter's StatefulShellRoute** for navigation management
- **Riverpod Provider** for state access and programmatic control

This gives you the best of both worlds: robust routing with easy state management.

## Architecture

### Components

```
┌─────────────────────────────────────────────────────────┐
│                    GoRouter                              │
│  ┌───────────────────────────────────────────────────┐  │
│  │         StatefulShellRoute.indexedStack           │  │
│  │  ┌─────────────────────────────────────────────┐  │  │
│  │  │      DashboardShellWrapper (Provider)       │  │  │
│  │  │  ┌───────────────────────────────────────┐  │  │  │
│  │  │  │   StatefulNavigationShell (GoRouter)  │  │  │  │
│  │  │  │   - Home Branch                       │  │  │  │
│  │  │  │   - Map Branch                        │  │  │  │
│  │  │  │   - Delivery Branch                   │  │  │  │
│  │  │  │   - More Branch                       │  │  │  │
│  │  │  └───────────────────────────────────────┘  │  │  │
│  │  │  ┌───────────────────────────────────────┐  │  │  │
│  │  │  │   DashboardBottomNav (Provider)       │  │  │  │
│  │  │  └───────────────────────────────────────┘  │  │  │
│  │  └─────────────────────────────────────────────┘  │  │
│  └───────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

### File Structure

```
lib/
├── dashboard_shell.dart              # Hybrid shell implementation
│   ├── DashboardState                # State model
│   ├── DashboardController           # Provider controller
│   ├── dashboardControllerProvider   # Riverpod provider
│   ├── DashboardShellWrapper         # Shell wrapper widget
│   └── DashboardBottomNav            # Bottom navigation UI
│
└── routes/
    └── app_routes.dart               # GoRouter configuration
```

## How It Works

### 1. GoRouter Manages Navigation

Each tab has its own navigation branch with independent navigation stack:

```dart
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return DashboardShellWrapper(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: _shellNavigatorHomeKey,
      routes: [
        GoRoute(
          path: home,
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: transactions,
              builder: (context, state) => const TransactionsScreen(),
            ),
          ],
        ),
      ],
    ),
    // ... other branches
  ],
)
```

### 2. Provider Syncs with Shell

The provider automatically syncs with the shell's current index:

```dart
class DashboardShellWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sync provider state with shell state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardControllerProvider.notifier)
         .syncWithShell(navigationShell.currentIndex);
    });
    
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DashboardBottomNav(
        navigationShell: navigationShell,
      ),
    );
  }
}
```

### 3. Bottom Nav Updates Both

When a tab is tapped:
1. Provider state is updated
2. Shell navigation is triggered
3. UI reflects the change

```dart
void _onTap(BuildContext context, WidgetRef ref, int index) {
  // Update provider state
  ref.read(dashboardControllerProvider.notifier).setIndex(index);
  
  // Navigate using shell
  navigationShell.goBranch(
    index,
    initialLocation: index == navigationShell.currentIndex,
  );
}
```

## Usage Examples

### Navigate to a Tab

**Option 1: Using GoRouter (Recommended)**
```dart
// Navigate to home tab
context.go(AppRoutes.home);

// Navigate to map tab
context.go(AppRoutes.map);

// Navigate to delivery tab
context.go(AppRoutes.delivery);

// Navigate to more tab
context.go(AppRoutes.more);
```

**Option 2: Using Provider**
```dart
// Get the controller
final controller = ref.read(dashboardControllerProvider.notifier);

// Navigate to a tab by index
controller.setIndex(2); // Delivery tab
```

### Access Current Tab

```dart
// Watch the current tab index
final currentTab = ref.watch(dashboardControllerProvider).currentIndex;

// Use in UI
if (currentTab == 0) {
  // User is on home tab
}
```

### Nested Navigation

```dart
// Navigate to a nested route within home tab
context.push('${AppRoutes.home}/${AppRoutes.transactions}');

// The bottom nav stays visible
// The back button returns to home
```

### Check if on Specific Tab

```dart
class HomeSpecificWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isOnHomeTab = ref.watch(dashboardControllerProvider).currentIndex == 0;
    
    if (!isOnHomeTab) {
      return const SizedBox.shrink();
    }
    
    return const Text('Only visible on home tab');
  }
}
```

## Routes Reference

| Route | Tab | Index | Screen |
|-------|-----|-------|--------|
| `/home` | Home | 0 | HomeScreen |
| `/map` | Map | 1 | MapPlaceholderScreen |
| `/delivery` | Delivery | 2 | DeliveryPlaceholderScreen |
| `/more` | More | 3 | MoreScreen |

### Nested Routes

- `/home/transactions` - Transactions screen (within home tab)

### Standalone Routes

- `/withdrawal` - Withdrawal screen (no bottom nav)
- `/withdrawal_verification` - Withdrawal verification (no bottom nav)
- `/withdrawal_success` - Withdrawal success (no bottom nav)
- `/account_details` - Account details (no bottom nav)

## Benefits

### From GoRouter Shell
✅ Each tab has independent navigation stack  
✅ State preservation when switching tabs  
✅ Support for nested routes within tabs  
✅ Deep linking support  
✅ URL-based navigation (web support)  
✅ Back button handling per tab  

### From Provider
✅ Access current tab from anywhere  
✅ Programmatic tab switching  
✅ Easy state management  
✅ Testable controller logic  
✅ React to tab changes  
✅ Conditional UI based on tab  

## Common Patterns

### Navigate After Action

```dart
// After successful withdrawal
context.go(AppRoutes.home);
```

### Navigate to Tab and Nested Route

```dart
// Go to home tab, then push transactions
context.go(AppRoutes.home);
Future.delayed(Duration.zero, () {
  context.push('${AppRoutes.home}/${AppRoutes.transactions}');
});
```

### Show Different Content Per Tab

```dart
class AdaptiveWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(dashboardControllerProvider).currentIndex;
    
    return switch (currentTab) {
      0 => const HomeContent(),
      1 => const MapContent(),
      2 => const DeliveryContent(),
      3 => const MoreContent(),
      _ => const SizedBox.shrink(),
    };
  }
}
```

### Listen to Tab Changes

```dart
class TabListener extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(dashboardControllerProvider, (previous, next) {
      if (previous?.currentIndex != next.currentIndex) {
        print('Tab changed from ${previous?.currentIndex} to ${next.currentIndex}');
        // Perform actions on tab change
      }
    });
    
    return const YourWidget();
  }
}
```

## Testing

### Test Navigation

```dart
testWidgets('Should navigate to map tab', (tester) async {
  await tester.pumpWidget(const MyApp());
  
  // Tap map tab
  await tester.tap(find.text('Map'));
  await tester.pumpAndSettle();
  
  // Verify map screen is shown
  expect(find.byType(MapPlaceholderScreen), findsOneWidget);
});
```

### Test Provider

```dart
test('Should update current index', () {
  final container = ProviderContainer();
  final controller = container.read(dashboardControllerProvider.notifier);
  
  controller.setIndex(2);
  
  expect(container.read(dashboardControllerProvider).currentIndex, 2);
});
```

## Migration from Pure Provider Approach

If you were using the pure provider approach (IndexedStack only):

**Before:**
```dart
context.go(AppRoutes.dashboard);
ref.read(dashboardControllerProvider.notifier).setIndex(2);
```

**After:**
```dart
context.go(AppRoutes.delivery);
// Provider syncs automatically
```

## Troubleshooting

### Tab not updating
- Make sure you're using `context.go()` not `context.push()`
- Check that the route path is correct

### State not preserved
- Verify each branch has a unique `navigatorKey`
- Ensure you're using `StatefulShellRoute.indexedStack`

### Provider out of sync
- The sync happens in `addPostFrameCallback`
- If issues persist, check the `syncWithShell` method

## Best Practices

1. **Use GoRouter for navigation** - Let the router handle navigation
2. **Use Provider for state** - Access current tab, react to changes
3. **Keep routes declarative** - Define all routes in `app_routes.dart`
4. **Preserve state** - Use separate navigator keys per branch
5. **Test both layers** - Test routing and provider logic separately

## Future Enhancements

Possible additions:
- Tab badges (notification counts)
- Tab animations
- Tab permissions/access control
- Tab history tracking
- Analytics on tab usage
- Dynamic tab visibility

---

This hybrid approach gives you maximum flexibility while keeping the code clean and maintainable.
