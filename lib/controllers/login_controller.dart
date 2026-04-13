import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/routes/app_routes.dart';

class LoginState {
  final String email;
  final String? errorMessage;

  const LoginState({
    required this.email,
    this.errorMessage,
  });

  LoginState copyWith({
    String? email,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      errorMessage: errorMessage,
    );
  }
}

class LoginController extends Notifier<LoginState> {
  @override
  LoginState build() {
    return const LoginState(email: '');
  }

  void onEmailChanged(String val) {
    state = state.copyWith(email: val, errorMessage: null);
  }

  void onNextPressed(BuildContext context) {
    context.push(AppRoutes.verification);
  }

  void onSocialLogin(String provider) {
  }
}

final loginControllerProvider = NotifierProvider<LoginController, LoginState>(LoginController.new);
