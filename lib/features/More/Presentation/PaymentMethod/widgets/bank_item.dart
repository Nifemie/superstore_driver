import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BankItem extends StatelessWidget {
  final String name;
  final String accountNumber;
  final String bankName;

  const BankItem({
    super.key,
    required this.name,
    required this.accountNumber,
    required this.bankName,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      child: Row(
        children: [
          // UBA Logo
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.asset(
              'assets/images/uba_logo.png',
              width: 40.r,
              height: 40.r,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1E1E1E),
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '$accountNumber - $bankName',
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: const Color(0xFF666666),
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: const Color(0xFFFF7D33),
            size: 16.sp,
          ),
        ],
      ),
    );
  }
}
