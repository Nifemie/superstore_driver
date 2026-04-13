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
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: _buildActivityStat('Earnings Today', state.todayEarnings.toCurrency())),
                const VerticalDivider(
                  color: Color(0xFFE0E0E0),
                  thickness: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                Expanded(child: _buildActivityStat('Online', state.onlineTime)),
                const VerticalDivider(
                  color: Color(0xFFE0E0E0),
                  thickness: 1,
                  indent: 15,
                  endIndent: 15,
                ),
                Expanded(child: _buildActivityStat('Rides Today', state.totalRidesToday.toString().padLeft(2, '0'))),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActivityStat(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF9E9E9E),
              fontSize: 13.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
              fontFamily: 'Inter',
            ),
          ),
        ],
      ),
    );
  }
}
