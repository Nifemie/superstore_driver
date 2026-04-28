# Dashboard Navigation - Provider Approach

## Overview

The navigation has been refactored from GoRouter's `StatefulShellRoute` to a simpler provider-based approach using Riverpod and `IndexedStack`.

## Architecture

### File Structure

```
lib/
├── dashboard_shell.dart              # Main dashboard with provider
├── routes/app_routes.dart            # Updated routing configuration
└── core/
    └── providers/
        └── dashboard_provider_example.dart  # Usage examples
```

### Components

#### 1. DashboardState
Holds the current tab index:
```dart
class DashboardState {
  final int currentIndex;
}
```

#### 2. DashboardController
Manages tab navigation:
```dart
class DashboardController extends Notifier<DashboardState> {
  void setIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
```

#### 3. DashboardShell
Main widget that displays screens with bottom navigation:
```dart
DashboardShell(
  screens: const [
    HomeScreen(),
    MapPlaceholderScreen(),
    DeliveryPlaceholderScreen(),
    MoreScreen(),
  ],
)
```

#### 4. DashboardBottomNav
Custom bottom navigation bar with 4 tabs.

## Tab Indices

| Index | Tab      | Screen                    |
|-------|----------|---------------------------|
| 0     | Home     | HomeScreen                |
| 1     | Map      | MapPlaceholderScreen      |
| 2     | Delivery | DeliveryPlaceholderScreen |
| 3     | More     | MoreScreen                |

## Usage

### Navigate to a specific tab

```dart
// From any widget with WidgetRef
ref.read(dashboardControllerProvider.notifier).setIndex(2); // Go to Delivery tab
```

### Watch current tab

```dart
final dashboardState = ref.watch(dashboardControllerProvider);
final currentTab = dashboardState.currentIndex;
```

### Navigate to dashboard from other screens

```dart
context.go(AppRoutes.dashboard);
```

## Benefits

1. **Simpler Architecture**: No complex shell routes or multiple navigator keys
2. **State Preservation**: `IndexedStack` keeps all tabs alive and preserves state
3. **Easy Access**: Control navigation from anywhere using the provider
4. **Type-Safe**: Provider-based approach with compile-time safety
5. **Testable**: Easy to test controller logic independently
6. **Flexible**: Can easily add features like tab badges, animations, etc.

## Migration Notes

### Changed Routes

- `AppRoutes.home` → `AppRoutes.dashboard`
- `AppRoutes.map` → Removed (now part of dashboard)
- `AppRoutes.delivery` → Removed (now part of dashboard)
- `AppRoutes.more` → Removed (now part of dashboard)
- `AppRoutes.transactions` → Now a standalone route (not nested)

### Updated Files

- `lib/routes/app_routes.dart` - Simplified routing
- `lib/features/Auth/Presentation/Splashscreen/splashscreen.dart`
- `lib/features/Auth/Presentation/Register/under_review_screen.dart`
- `lib/features/Auth/Presentation/Register/kyc_status_screen.dart`
- `lib/features/Withdrawal/Presentation/withdrawal_success_screen.dart`
- `lib/features/Home/Presentation/widgets/transactions_section.dart`

### Removed Files

The following files are no longer needed but kept for reference:
- `lib/core/widgets/scaffold_with_navbar.dart`
- `lib/features/Home/Presentation/widgets/home_bottom_nav.dart`

## Future Enhancements

Possible additions to the dashboard provider:

1. **Tab History**: Track navigation history
2. **Tab Badges**: Show notification counts
3. **Tab Animations**: Custom transitions
4. **Tab Permissions**: Control access to tabs
5. **Deep Linking**: Handle deep links to specific tabs
6. **Tab State**: Save/restore tab state on app restart

## Example: Navigate from Home to More

```dart
class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to More tab
        ref.read(dashboardControllerProvider.notifier).setIndex(3);
      },
      child: const Text('Go to Profile'),
    );
  }
}
```
