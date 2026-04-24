import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/controllers/home_controller.dart';
import 'package:superstore_driver/controllers/withdrawal_controller.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/utils/currency_formatter.dart';

class WithdrawalBalanceCard extends ConsumerWidget {
  const WithdrawalBalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawalState = ref.watch(withdrawalControllerProvider);
    final homeState = ref.watch(homeControllerProvider);

    return Column(
      children: [
        SizedBox(height: 20.h),
        // Main amount with cursor
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              withdrawalState.amountValue.toCurrency(),
              style: TextStyle(
                color: const Color(0xFF1E1E1E),
                fontSize: 40.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
            Container(
              width: 1.5.w,
              height: 40.h,
              margin: EdgeInsets.only(left: 4.w),
              decoration: BoxDecoration(
                color: const Color(0xFF2D60FF),
                borderRadius: BorderRadius.circular(1.r),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Container(
          color: const Color(0xFFE8E8E8),
          height: 1.h,
          width: double.infinity,
        ),
        SizedBox(height: 16.h),
        
        // Figures Section - Centered
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Total and Fee Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildStat(withdrawalState.total.toCurrency(), 'Total'),
                Container(
                  width: 4.r,
                  height: 4.r,
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
                _buildStat(withdrawalState.fee.toCurrency(), 'Fee'),
              ],
            ),
            SizedBox(height: 8.h),
            
            // Available Balance Row
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  homeState.totalEarnings.toCurrency(),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'Available balance',
                  style: TextStyle(
                    color: const Color(0xFF1E1E1E),
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStat(String value, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: TextStyle(
            color: const Color(0xFF1E1E1E),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Inter',
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            color: const Color(0xFF666666),
            fontSize: 14.sp,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
