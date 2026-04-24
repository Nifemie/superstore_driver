import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/routes/app_routes.dart';

class WithdrawalVerificationState {
  final String otp;
  final int timerSeconds;
  final bool canResend;
  final String? errorMessage;
  final bool isLoading;

  const WithdrawalVerificationState({
    required this.otp,
    required this.timerSeconds,
    required this.canResend,
    this.errorMessage,
    this.isLoading = false,
  });

  WithdrawalVerificationState copyWith({
    String? otp,
    int? timerSeconds,
    bool? canResend,
    String? errorMessage,
    bool? isLoading,
    bool clearError = false,
  }) {
    return WithdrawalVerificationState(
      otp: otp ?? this.otp,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      canResend: canResend ?? this.canResend,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class WithdrawalVerificationController extends Notifier<WithdrawalVerificationState> {
  Timer? _timer;

  @override
  WithdrawalVerificationState build() {
    ref.onDispose(() => _timer?.cancel());
    Future.microtask(() => _startTimer());
    return const WithdrawalVerificationState(
      otp: '',
      timerSeconds: 60,
      canResend: false,
    );
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.timerSeconds > 0) {
        state = state.copyWith(timerSeconds: state.timerSeconds - 1);
      } else {
        state = state.copyWith(canResend: true);
        _timer?.cancel();
      }
    });
  }

  void addDigit(String digit) {
    if (state.otp.length < 5) {
      state = state.copyWith(otp: state.otp + digit, clearError: true);
    }
  }

  void removeDigit() {
    if (state.otp.isNotEmpty) {
      state = state.copyWith(otp: state.otp.substring(0, state.otp.length - 1), clearError: true);
    }
  }

  void resendCode() {
    if (state.canResend) {
      state = state.copyWith(timerSeconds: 60, canResend: false, clearError: true);
      _startTimer();
    }
  }

  Future<void> confirmWithdrawal(BuildContext context) async {
    if (state.otp.length == 5) {
      state = state.copyWith(isLoading: true, clearError: true);
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (context.mounted) {
        state = state.copyWith(isLoading: false);
        // Show success and go back to home or a success screen
        context.go(AppRoutes.withdrawalSuccess);
      }
    } else {
      state = state.copyWith(errorMessage: 'Please enter a 5-digit OTP');
    }
  }
}

final withdrawalVerificationControllerProvider = NotifierProvider<WithdrawalVerificationController, WithdrawalVerificationState>(WithdrawalVerificationController.new);
