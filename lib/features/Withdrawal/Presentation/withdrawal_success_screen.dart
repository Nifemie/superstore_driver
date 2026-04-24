import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/routes/app_routes.dart';

class WithdrawalSuccessScreen extends StatelessWidget {
  const WithdrawalSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Success Icon
              Container(
                width: 100.r,
                height: 100.r,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F5E9),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    width: 70.r,
                    height: 70.r,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40.r,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              // Title
              Text(
                'N9,800 cashed out\nSuccessfully!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              SizedBox(height: 12.h),
              // Subtitle
              Text(
                'Your money should be available within 2-3hrs',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Inter',
                  color: const Color(0xFF666666),
                ),
              ),
              SizedBox(height: 40.h),
              // Details Card
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Text(
                      'Transaction Details',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: const Color(0xFF1E1E1E),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    _buildDetailRow('Transaction ID', '09284930293'),
                    _buildDetailRow('Amount tendered', 'N10,000'),
                    _buildDetailRow('Fees', '-N200'),
                    _buildDetailRow('Date', 'May 17, 2025'),
                    _buildDetailRow('Status', 'Success', isStatus: true),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              // Continue Button
              PrimaryButton(
                text: 'Continue',
                onPressed: () => context.go(AppRoutes.home),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isStatus = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              fontFamily: 'Inter',
              color: const Color(0xFF666666),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Inter',
              color: const Color(0xFF1E1E1E),
            ),
          ),
        ],
      ),
    );
  }
}
