import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/utils/currency_formatter.dart';
import 'package:superstore_driver/features/Home/Logic/home_logic.dart';

class ActivitiesSection extends StatelessWidget {
  final HomeState state;

  const ActivitiesSection({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Today's activities",
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildActivityStat('Earnings Today', state.todayEarnings.toCurrency()),
              const VerticalDivider(color: AppColors.divider),
              _buildActivityStat('Online', state.onlineTime),
              const VerticalDivider(color: AppColors.divider),
              _buildActivityStat('Rides Today', state.totalRidesToday.toString().padLeft(2, '0')),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityStat(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp, fontFamily: 'Inter'),
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(color: AppColors.textPrimary, fontSize: 18.sp, fontWeight: FontWeight.bold, fontFamily: 'Inter'),
        ),
      ],
    );
  }
}
