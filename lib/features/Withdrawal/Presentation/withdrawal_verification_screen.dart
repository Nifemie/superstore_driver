import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/controllers/withdrawal_verification_controller.dart';
import 'package:superstore_driver/core/widgets/otp_input_row.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/core/widgets/custom_numeric_keypad.dart';
import 'package:superstore_driver/features/Withdrawal/Presentation/widgets/withdrawal_appbar.dart';

class WithdrawalVerificationScreen extends ConsumerWidget {
  const WithdrawalVerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(withdrawalVerificationControllerProvider);
    final logic = ref.read(withdrawalVerificationControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WithdrawalAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter the verification code sent to you',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                    height: 1.1,
                    color: const Color(0xFF1E1E1E),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'We have sent an OTP to registered phone number to confirm withdrawal',
                  style: TextStyle(
                    color: const Color(0xFF666666),
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 32.h),
                OtpInputRow(otp: state.otp),
                if (state.errorMessage != null) ...[
                  SizedBox(height: 12.h),
                  Text(
                    state.errorMessage!,
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                SizedBox(height: 24.h),
                _ResendTimer(state: state, logic: logic),
                SizedBox(height: 32.h),
                PrimaryButton(
                  text: 'Confirm',
                  isLoading: state.isLoading,
                  onPressed: state.otp.length == 5
                      ? () => logic.confirmWithdrawal(context)
                      : null,
                ),
                SizedBox(height: 48.h),
                CustomNumericKeypad(
                  onDigitPressed: (digit) => logic.addDigit(digit),
                  onDeletePressed: () => logic.removeDigit(),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ResendTimer extends StatelessWidget {
  final WithdrawalVerificationState state;
  final WithdrawalVerificationController logic;
  const _ResendTimer({required this.state, required this.logic});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.refresh_rounded,
          size: 20.sp,
          color: const Color(0xFF666666),
        ),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: state.canResend ? () => logic.resendCode() : null,
          child: Text(
            state.canResend ? 'Resend code' : 'Resend code in ${state.timerSeconds}s',
            style: TextStyle(
              color: const Color(0xFF666666),
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
