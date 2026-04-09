import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  const HomeBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12.h, bottom: 20.h),
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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem('assets/images/nav_home.png', 'Home', isActive: true, isImage: true),
          _buildNavItem(Icons.map_outlined, 'Map'),
          _buildNavItem('assets/images/nav_delivery.png', 'Delivery', isImage: true),
          _buildNavItem('assets/images/nav_more.png', 'More', isImage: true),
        ],
      ),
    );
  }

  Widget _buildNavItem(dynamic iconOrPath, String label, {bool isActive = false, bool isImage = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isImage)
          Image.asset(
            iconOrPath as String,
            width: 28.r,
            height: 28.r,
            color: isActive ? AppColors.primary : AppColors.textSecondary,
          )
        else
          Icon(
            iconOrPath as IconData,
            color: isActive ? AppColors.primary : AppColors.textSecondary,
            size: 28.r,
          ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            color: isActive ? AppColors.primary : AppColors.textSecondary,
            fontSize: 12.sp,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Inter',
          ),
        ),
      ],
    );
  }
}
