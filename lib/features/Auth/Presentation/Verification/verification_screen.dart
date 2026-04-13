import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/app_circle_button.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/controllers/verification_controller.dart';

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
                                'Enter the verification code\nsent to you',
                                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                      fontWeight: FontWeight.w900,
                                      height: 1.1,
                                    ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                'We have sent an OTP to \u201cJohndoe@gmail.com\u201d',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
                              ),
                              SizedBox(height: 20.h),
                              _OtpInputRow(otp: state.otp),
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
                              _CustomKeypad(logic: logic),
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

class _OtpInputRow extends StatelessWidget {
  final String otp;
  const _OtpInputRow({required this.otp});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(5, (index) {
        final isFilled = index < otp.length;
        final isActive = index == otp.length;
        return Container(
          height: 52.r,
          width: 52.r,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isActive ? AppColors.primary : AppColors.divider.withOpacity(0.5),
              width: isActive ? 2 : 1,
            ),
          ),
          alignment: Alignment.center,
          child: Text(isFilled ? otp[index] : '', style: Theme.of(context).textTheme.headlineSmall),
        );
      }),
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
        Icon(Icons.refresh_rounded, size: 20.r, color: AppColors.textSecondary),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: state.canResend ? () => logic.resendCode() : null,
          child: Text(
            state.canResend ? 'Resend code' : 'Resend code in ${state.timerSeconds}s',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: state.canResend ? AppColors.primary : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _CustomKeypad extends StatelessWidget {
  final VerificationController logic;
  const _CustomKeypad({required this.logic});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(['1', '2', '3']),
        SizedBox(height: 12.h),
        _buildRow(['4', '5', '6']),
        SizedBox(height: 12.h),
        _buildRow(['7', '8', '9']),
        SizedBox(height: 12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 64.r, height: 64.r),
            AppCircleButton(text: '0', onTap: () => logic.addDigit('0')),
            AppCircleButton(
              icon: Icons.backspace_outlined,
              iconColor: Colors.redAccent,
              onTap: () => logic.removeDigit(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: keys.map((key) => AppCircleButton(text: key, onTap: () => logic.addDigit(key))).toList(),
    );
  }
}
