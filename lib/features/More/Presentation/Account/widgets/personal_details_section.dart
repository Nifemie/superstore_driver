import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonalDetailsSection extends StatelessWidget {
  const PersonalDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Personal Details',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E1E1E),
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(height: 24.h),
        _buildDetailRow('Full Name', 'John Doe'),
        _buildDetailRow('Email', 'johndoe@gmail.com'),
        _buildDetailRow('Mobile Number', '07066346320'),
        _buildDetailRow('Date of Birth', '26 Mar, 2025'),
        _buildDetailRow('Gender', 'Male'),
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: const Color(0xFF666666),
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
      ),
    );
  }
}
