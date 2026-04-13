import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/Auth/Presentation/Login/login_screen.dart';
import '../features/Auth/Presentation/Splashscreen/splashscreen.dart';
import '../features/Auth/Presentation/Verification/verification_screen.dart';
import '../features/Auth/Presentation/Register/register_screen.dart';
import '../features/Auth/Presentation/Identity/identity_verification_screen.dart';
import '../features/Auth/Presentation/Business/business_verification_screen.dart';
import '../features/Auth/Presentation/Business/business_document_upload_screen.dart';
import '../features/Auth/Presentation/Bank/bank_details_screen.dart';
import '../features/Auth/Presentation/Register/under_review_screen.dart';
import '../features/Home/Presentation/home_screen.dart';
import '../features/Transactions/Presentation/transactions_screen.dart';
import '../features/Home/Presentation/placeholder_screens.dart';
import '../core/widgets/scaffold_with_navbar.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String verification = '/verification';
  static const String register = '/register';
  static const String identityVerification = '/identity_verification';
  static const String businessVerification = '/business_verification';
  static const String businessUpload = '/business_upload';
  static const String bankDetails = '/bank_details';
  static const String underReview = '/under_review';
  static const String home = '/home';
  static const String transactions = 'transactions'; // Sub-route of home
  static const String map = '/map';
  static const String delivery = '/delivery';
  static const String more = '/more';

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorMapKey = GlobalKey<NavigatorState>(debugLabel: 'shellMap');
  static final _shellNavigatorDeliveryKey = GlobalKey<NavigatorState>(debugLabel: 'shellDelivery');
  static final _shellNavigatorMoreKey = GlobalKey<NavigatorState>(debugLabel: 'shellMore');

  static final router = GoRouter(
    initialLocation: splash,
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: verification,
        builder: (context, state) => const VerificationScreen(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: identityVerification,
        builder: (context, state) => const IdentityVerificationScreen(),
      ),
      GoRoute(
        path: businessVerification,
        builder: (context, state) => const BusinessVerificationScreen(),
      ),
      GoRoute(
        path: businessUpload,
        builder: (context, state) => const BusinessDocumentUploadScreen(),
      ),
      GoRoute(
        path: bankDetails,
        builder: (context, state) => const BankDetailsScreen(),
      ),
      GoRoute(
        path: underReview,
        builder: (context, state) => const UnderReviewScreen(),
      ),

      // Stateful Shell Route
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          // Home Branch
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
          // Map Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMapKey,
            routes: [
              GoRoute(
                path: map,
                builder: (context, state) => const MapPlaceholderScreen(),
              ),
            ],
          ),
          // Delivery Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorDeliveryKey,
            routes: [
              GoRoute(
                path: delivery,
                builder: (context, state) => const DeliveryPlaceholderScreen(),
              ),
            ],
          ),
          // More Branch
          StatefulShellBranch(
            navigatorKey: _shellNavigatorMoreKey,
            routes: [
              GoRoute(
                path: more,
                builder: (context, state) => const MorePlaceholderScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
