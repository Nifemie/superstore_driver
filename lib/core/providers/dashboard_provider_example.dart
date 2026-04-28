// Example: How to use the Dashboard Provider with GoRouter Shell
// 
// The DashboardController works in sync with GoRouter's StatefulNavigationShell.
// This gives you the best of both worlds:
// - GoRouter manages navigation stacks per tab
// - Provider gives you programmatic control and state access

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../dashboard_shell.dart';
import '../../routes/app_routes.dart';

// Example 1: Navigate to a specific tab programmatically
class NavigateToTabExample extends ConsumerWidget {
  const NavigateToTabExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // Option 1: Use provider (updates UI state)
        ref.read(dashboardControllerProvider.notifier).setIndex(3);
        
        // Option 2: Use GoRouter (recommended for navigation)
        context.go(AppRoutes.more);
        
        // The provider will automatically sync with the shell
      },
      child: const Text('Go to More Tab'),
    );
  }
}

// Example 2: Get current tab index
class CurrentTabExample extends ConsumerWidget {
  const CurrentTabExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardState = ref.watch(dashboardControllerProvider);
    
    return Text('Current Tab: ${dashboardState.currentIndex}');
  }
}

// Example 3: Navigate using GoRouter (Recommended)
class GoRouterNavigationExample extends ConsumerWidget {
  const GoRouterNavigationExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => context.go(AppRoutes.home),
          child: const Text('Go to Home'),
        ),
        ElevatedButton(
          onPressed: () => context.go(AppRoutes.map),
          child: const Text('Go to Map'),
        ),
        ElevatedButton(
          onPressed: () => context.go(AppRoutes.delivery),
          child: const Text('Go to Delivery'),
        ),
        ElevatedButton(
          onPressed: () => context.go(AppRoutes.more),
          child: const Text('Go to More'),
        ),
      ],
    );
  }
}

// Example 4: Nested navigation within a tab
class NestedNavigationExample extends ConsumerWidget {
  const NestedNavigationExample({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () {
        // Navigate to transactions screen within the home tab
        context.push('${AppRoutes.home}/${AppRoutes.transactions}');
      },
      child: const Text('View Transactions'),
    );
  }
}

// Tab routes reference:
// AppRoutes.home - Home tab (index 0)
// AppRoutes.map - Map tab (index 1)
// AppRoutes.delivery - Delivery tab (index 2)
// AppRoutes.more - More tab (index 3)

// Benefits of this hybrid approach:
// 1. Each tab has its own navigation stack (via GoRouter)
// 2. State is preserved when switching tabs
// 3. Provider gives you access to current tab index
// 4. Can navigate programmatically from anywhere
// 5. Supports deep linking and nested routes
