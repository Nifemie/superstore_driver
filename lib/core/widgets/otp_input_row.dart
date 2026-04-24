import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class OtpInputRow extends StatelessWidget {
  final String otp;
  const OtpInputRow({super.key, required this.otp});

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
          child: Text(
            isFilled ? otp[index] : '',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              color: const Color(0xFF1E1E1E),
            ),
          ),
        );
      }),
    );
  }
}
