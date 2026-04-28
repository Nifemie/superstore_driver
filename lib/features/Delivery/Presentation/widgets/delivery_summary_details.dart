import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliverySummaryDetails extends StatelessWidget {
  const DeliverySummaryDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Pickup Code
          _buildDetailRow('Pickup-code', 'JUK-0029273'),
          SizedBox(height: 16.h),
          // Pickup Point
          _buildLocationDetail(
            'Pickup point',
            'Jujin Labu, Janbulo, Kano state',
            '3:24pm',
            Icons.circle,
            const Color(0xFF2196F3),
          ),
          SizedBox(height: 16.h),
          // Destination
          _buildLocationDetail(
            'Destination',
            '62 Hawan Dawaki Kano state',
            '4:10pm',
            Icons.location_on,
            const Color(0xFFFF7D33),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF999999),
            fontFamily: 'Inter',
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E1E1E),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }

  Widget _buildLocationDetail(
    String label,
    String address,
    String time,
    IconData icon,
    Color iconColor,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFE0E0E0),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 16.r,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF999999),
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                address,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E1E1E),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),
        Text(
          time,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF999999),
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
