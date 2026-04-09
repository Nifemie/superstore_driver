import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.5, 
            letterSpacing: 14.sp * 0.02, 
            fontFamily: 'Inter',
          ),
          children: [
            const TextSpan(text: 'By signing up, you agree to our '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'Terms & Conditions',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            const TextSpan(text: ', acknowledging our '),
            WidgetSpan(
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
            const TextSpan(text: ', and confirm that you are above 18.'),
          ],
        ),
      ),
    );
  }
}
