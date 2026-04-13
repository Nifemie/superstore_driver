import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:superstore_driver/routes/app_routes.dart';

part 'login_logic.g.dart';

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

@riverpod
class LoginLogic extends _$LoginLogic {
  @override
  LoginState build() {
    return const LoginState(email: '');
  }

  void onEmailChanged(String val) {
    state = state.copyWith(email: val, errorMessage: null);
  }

  void onNextPressed(BuildContext context) {
    if (_isValidEmail(state.email)) {
      context.push(AppRoutes.verification);
    } else {
      state = state.copyWith(errorMessage: 'Please enter a valid email address');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void onSocialLogin(String provider) {
    // Social login implementation
  }
}
