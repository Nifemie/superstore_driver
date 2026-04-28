# Migration Guide: GoRouter Shell to Provider-Based Navigation

## What Changed?

The app navigation has been refactored from GoRouter's `StatefulShellRoute` to a simpler provider-based approach using Riverpod.

## Before vs After

### Before (GoRouter Shell Approach)

```dart
// Multiple navigator keys
static final _shellNavigatorHomeKey = GlobalKey<NavigatorState>();
static final _shellNavigatorMapKey = GlobalKey<NavigatorState>();
static final _shellNavigatorDeliveryKey = GlobalKey<NavigatorState>();
static final _shellNavigatorMoreKey = GlobalKey<NavigatorState>();

// Complex shell route configuration
StatefulShellRoute.indexedStack(
  builder: (context, state, navigationShell) {
    return ScaffoldWithNavBar(navigationShell: navigationShell);
  },
  branches: [
    StatefulShellBranch(
      navigatorKey: _shellNavigatorHomeKey,
      routes: [
        GoRoute(path: home, builder: (context, state) => const HomeScreen()),
      ],
    ),
    // ... more branches
  ],
)

// Navigation
context.go(AppRoutes.home);
```

### After (Provider Approach)

```dart
// Single root navigator
static final _rootNavigatorKey = GlobalKey<NavigatorState>();

// Simple route configuration
GoRoute(
  path: dashboard,
  builder: (context, state) => DashboardShell(
    screens: const [
      HomeScreen(),
      MapPlaceholderScreen(),
      DeliveryPlaceholderScreen(),
      MoreScreen(),
    ],
  ),
)

// Navigation
context.go(AppRoutes.dashboard);

// Tab switching from anywhere
ref.read(dashboardControllerProvider.notifier).setIndex(2);
```

## Key Differences

| Aspect | Before | After |
|--------|--------|-------|
| **Complexity** | High - Multiple navigator keys and shell branches | Low - Single provider and IndexedStack |
| **State Management** | GoRouter manages state | Riverpod provider manages state |
| **Tab Switching** | Via route navigation | Via provider method call |
| **Code Lines** | ~80 lines for routing setup | ~30 lines for routing setup |
| **Navigator Keys** | 4 separate keys | 1 root key |
| **Flexibility** | Limited to routing | Full programmatic control |

## Code Changes Required

### 1. Update Route References

```dart
// OLD
context.go(AppRoutes.home);
context.go(AppRoutes.map);
context.go(AppRoutes.delivery);
context.go(AppRoutes.more);

// NEW
context.go(AppRoutes.dashboard);
// Then use provider to switch tabs if needed
ref.read(dashboardControllerProvider.notifier).setIndex(0); // Home
ref.read(dashboardControllerProvider.notifier).setIndex(1); // Map
ref.read(dashboardControllerProvider.notifier).setIndex(2); // Delivery
ref.read(dashboardControllerProvider.notifier).setIndex(3); // More
```

### 2. Update Nested Routes

```dart
// OLD
context.push('${AppRoutes.home}/${AppRoutes.transactions}');

// NEW
context.push(AppRoutes.transactions);
```

### 3. Access Current Tab

```dart
// OLD
// Not easily accessible

// NEW
final currentTab = ref.watch(dashboardControllerProvider).currentIndex;
```

## Benefits of New Approach

1. **Simpler Code**: Less boilerplate, easier to understand
2. **Better Control**: Programmatic tab switching from anywhere
3. **State Access**: Easy to read current tab state
4. **Testability**: Provider logic is easily testable
5. **Flexibility**: Can add features like tab badges, animations, etc.
6. **Performance**: IndexedStack keeps all tabs alive (same as before)

## When to Use Each Approach

### Use Provider Approach (Current) When:
- You want simple tab navigation
- You need programmatic control over tabs
- You want to access tab state from anywhere
- Your app has a fixed set of bottom tabs

### Use GoRouter Shell When:
- You need complex nested navigation within tabs
- You want deep linking to specific tab states
- You need separate navigation stacks per tab with history
- You're building a web app with URL-based navigation

## Testing the Changes

Run the app and verify:
1. ✅ Bottom navigation switches between tabs
2. ✅ Tab state is preserved when switching
3. ✅ Navigation from splash/login goes to dashboard
4. ✅ Withdrawal success returns to dashboard
5. ✅ Transactions screen is accessible from home

## Rollback Instructions

If you need to revert to the old approach:

1. Restore `lib/core/widgets/scaffold_with_navbar.dart`
2. Restore `lib/features/Home/Presentation/widgets/home_bottom_nav.dart`
3. Revert changes in `lib/routes/app_routes.dart`
4. Update all `AppRoutes.dashboard` back to `AppRoutes.home`
5. Delete `lib/dashboard_shell.dart`

## Questions?

The new approach is simpler and more maintainable for most use cases. If you have specific requirements that need the shell route approach, we can discuss hybrid solutions.
