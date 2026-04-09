import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class RegistrationTabs extends StatelessWidget {
  final int activeIndex;
  const RegistrationTabs({super.key, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab('Rider verification', activeIndex >= 0),
        SizedBox(width: 8.w),
        _buildTab('Business verification', activeIndex >= 1),
        SizedBox(width: 8.w),
        _buildTab('Bank details', activeIndex >= 2),
      ],
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              height: 1.0,
              letterSpacing: 0,
              color: isActive ? AppColors.primary : AppColors.textSecondary.withOpacity(0.6),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Container(
            height: 3.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.divider.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }
}
