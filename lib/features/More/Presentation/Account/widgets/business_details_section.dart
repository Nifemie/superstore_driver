import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusinessDetailsSection extends StatelessWidget {
  const BusinessDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Business details',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1E1E),
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 24.h),
        _buildDetailRow('Business name', 'Xpress-services'),
        _buildDetailRow('State', 'Kano'),
        _buildDetailRow('City', 'Hawan dawaki'),
        _buildDetailRow('Address', 'No 1, Mobile line, Bakar Lamba, hawan dawaki, Kano state'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF666666),
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E1E1E),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
