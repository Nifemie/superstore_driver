import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/controllers/home_controller.dart';

class StatusToggle extends ConsumerWidget {
  const StatusToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeControllerProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Riders status',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            Row(
              children: [
                Container(
                  width: 8.r,
                  height: 8.r,
                  decoration: BoxDecoration(
                    color: state.isOnline ? const Color(0xFF4CAF50) : AppColors.grey,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.w),
                Text(
                  state.isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    color: state.isOnline ? const Color(0xFF4CAF50) : AppColors.textSecondary,
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ],
        ),
        Switch(
          value: state.isOnline,
          onChanged: (_) => ref.read(homeControllerProvider.notifier).toggleOnline(),
          activeColor: AppColors.primary,
        ),
      ],
    );
  }
}
