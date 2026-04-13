import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/app_text_field.dart';

class PhoneField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final String? initialValue;
  final bool showCheckMark;

  const PhoneField({super.key, required this.onChanged, this.initialValue, this.showCheckMark = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Phone number', style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
        SizedBox(height: 8.h),
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.divider),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/icons/nigeria_flag.png',
                      width: 20.w,
                      height: 20.w,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.flag, size: 20),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    '+234',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AppTextField(
                hintText: '07012345678',
                initialValue: initialValue,
                onChanged: onChanged,
                showCheckMark: showCheckMark,
                keyboardType: TextInputType.phone,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

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
