import 'package:flutter/material.dart';
import '../features/Auth/Presentation/Login/login_screen.dart';
import '../features/Auth/Presentation/Splashscreen/splashscreen.dart';
import '../features/Auth/Presentation/Verification/verification_screen.dart';
import '../features/Auth/Presentation/Register/register_screen.dart';
import '../features/Auth/Presentation/Identity/identity_verification_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String verification = '/verification';
  static const String register = '/register';
  static const String identityVerification = '/identity_verification';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    verification: (context) => const VerificationScreen(),
    register: (context) => const RegisterScreen(),
    identityVerification: (context) => const IdentityVerificationScreen(),
  };
}
