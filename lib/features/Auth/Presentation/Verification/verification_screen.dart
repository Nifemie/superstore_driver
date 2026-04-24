import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/controllers/verification_controller.dart';
import 'package:superstore_driver/core/widgets/otp_input_row.dart';
import 'package:superstore_driver/features/Auth/Presentation/Verification/widgets/verification_keypad.dart';

class VerificationScreen extends ConsumerWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(verificationControllerProvider);
    final logic = ref.read(verificationControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, top: 16.h),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                          onPressed: () => context.pop(),
                        ),
                      ),
                    ),
                    Expanded(
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
                                'We have sent an OTP to \u201cJohndoe@gmail.com\u201d',
                                style: TextStyle(
                                  color: const Color(0xFF666666),
                                  fontSize: 14.sp,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              OtpInputRow(otp: state.otp),
                              if (state.errorMessage != null) ...[
                                SizedBox(height: 12.h),
                                Row(
                                  children: [
                                    Icon(Icons.error_rounded, color: Colors.red, size: 16.r),
                                    SizedBox(width: 8.w),
                                    Text(
                                      state.errorMessage!,
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                              SizedBox(height: 16.h),
                              _ResendTimer(state: state, logic: logic),
                              SizedBox(height: 24.h),
                              PrimaryButton(
                                text: 'Next',
                                onPressed: state.otp.length == 5
                                    ? () => logic.verifyCode(context)
                                    : null,
                              ),
                              SizedBox(height: 24.h),
                              const VerificationKeypad(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResendTimer extends StatelessWidget {
  final VerificationState state;
  final VerificationController logic;
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
