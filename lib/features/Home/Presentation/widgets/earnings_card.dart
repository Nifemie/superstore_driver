import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/utils/currency_formatter.dart';
import 'package:superstore_driver/features/Home/Logic/home_logic.dart';

class EarningsCard extends ConsumerWidget {
  const EarningsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeLogicProvider);
    
    return Container(
      width: double.infinity,
      height: 114.h,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Your earnings',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(width: 8.w),
                    GestureDetector(
                      onTap: () => ref.read(homeLogicProvider.notifier).toggleEarningsVisibility(),
                      child: Icon(
                        state.showEarnings ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Colors.white.withOpacity(0.9),
                        size: 20.r,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  state.showEarnings ? state.totalEarnings.toCurrency() : '₦ ********',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27.sp,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 134.w,
            height: 40.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Text(
              'Withdraw earnings',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
