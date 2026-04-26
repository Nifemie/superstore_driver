import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerificationDocumentItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String status;
  final bool isApproved;

  const VerificationDocumentItem({
    super.key,
    required this.icon,
    required this.title,
    required this.status,
    this.isApproved = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: const BoxDecoration(
              color: Color(0xFFFFF7ED),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFF7D33),
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E1E1E),
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xFF666666),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          if (isApproved)
            Icon(
              Icons.check_circle,
              color: const Color(0xFF4CAF50),
              size: 24.sp,
            ),
        ],
      ),
    );
  }
}
