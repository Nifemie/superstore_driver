import 'package:flutter/material.dart';
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
  static const String transactions = '/transactions';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    verification: (context) => const VerificationScreen(),
    register: (context) => const RegisterScreen(),
    identityVerification: (context) => const IdentityVerificationScreen(),
    businessVerification: (context) => const BusinessVerificationScreen(),
    businessUpload: (context) => const BusinessDocumentUploadScreen(),
    bankDetails: (context) => const BankDetailsScreen(),
    underReview: (context) => const UnderReviewScreen(),
    home: (context) => const HomeScreen(),
    transactions: (context) => const TransactionsScreen(),
  };
}
