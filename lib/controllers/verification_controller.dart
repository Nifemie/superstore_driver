import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/core/services/local_storage_service.dart';
import 'package:superstore_driver/routes/app_routes.dart';

class VerificationState {
  final String otp;
  final int timerSeconds;
  final bool canResend;
  final String? errorMessage;

  const VerificationState({
    required this.otp,
    required this.timerSeconds,
    required this.canResend,
    this.errorMessage,
  });

  VerificationState copyWith({
    String? otp,
    int? timerSeconds,
    bool? canResend,
    String? errorMessage,
    bool clearError = false,
  }) {
    return VerificationState(
      otp: otp ?? this.otp,
      timerSeconds: timerSeconds ?? this.timerSeconds,
      canResend: canResend ?? this.canResend,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class VerificationController extends Notifier<VerificationState> {
  Timer? _timer;

  @override
  VerificationState build() {
    _startTimer();
    return const VerificationState(
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
      state = state.copyWith(
        otp: state.otp + digit,
        clearError: true,
      );
    }
  }

  void removeDigit() {
    if (state.otp.isNotEmpty) {
      state = state.copyWith(
        otp: state.otp.substring(0, state.otp.length - 1),
        clearError: true,
      );
    }
  }

  void verifyCode(BuildContext context) {
    if (state.otp.length == 5) {
      state = state.copyWith(clearError: true);
      LocalStorageService.setLoggedIn(true);
      context.push(AppRoutes.register);
    } else {
      state = state.copyWith(errorMessage: 'Please enter a 5-digit OTP');
    }
  }

  void resendCode() {
    if (state.canResend) {
      state = state.copyWith(timerSeconds: 60, canResend: false, clearError: true);
      _startTimer();
    }
  }
}

final verificationControllerProvider = NotifierProvider<VerificationController, VerificationState>(VerificationController.new);
