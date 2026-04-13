import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class FooterText extends StatelessWidget {
  const FooterText({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
            height: 1.5,
            fontFamily: 'Inter',
          ),
          children: [
            const TextSpan(text: 'By signing up, you agree to our '),
            TextSpan(text: 'Terms & Conditions', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            const TextSpan(text: ', acknowledging our '),
            TextSpan(text: 'Privacy Policy', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            const TextSpan(text: ', and confirm that you are above 18.'),
          ],
        ),
      ),
    );
  }
}
