import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 68.h,
        width: 428.w,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(child: _buildNavItem('assets/images/nav_home.png', 'Home', top: 17.h, left: 24.w, isActive: true, isImage: true)),
            Expanded(child: _buildNavItem(Icons.map_outlined, 'Map', top: 15.h, left: 25.w)),
            Expanded(child: _buildNavItem('assets/images/nav_delivery.png', 'Delivery', top: 15.h, left: 25.w, isImage: true)),
            Expanded(child: _buildNavItem('assets/images/nav_more.png', 'More', top: 15.5.h, left: 21.w, isImage: true)),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    dynamic iconOrPath,
    String label, {
    required double top,
    required double left,
    bool isActive = false,
    bool isImage = false,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: top, left: left),
          child: isImage
              ? Image.asset(
                  iconOrPath as String,
                  width: 24.r,
                  height: 24.r,
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                )
              : Icon(
                  iconOrPath as IconData,
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                  size: 24.r,
                ),
        ),
        SizedBox(height: 4.h),
        Padding(
          padding: EdgeInsets.only(left: left),
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.primary : AppColors.textSecondary,
              fontSize: 11.sp,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ],
    );
  }
}
