import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripsStatsCard extends StatelessWidget {
  const TripsStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFEEEEEE)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Trips completed',
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF666666),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '300 Trips over 2 years',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E1E1E),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Acceptance Rate', 'N30,000'),
              _buildDivider(),
              _buildStatItem('Cancellation rate', '02'),
              _buildDivider(),
              _buildStatItem('Ratings', '4.0'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: const Color(0xFF999999),
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E1E1E),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 30.h,
      width: 1,
      color: const Color(0xFFEEEEEE),
    );
  }
}
