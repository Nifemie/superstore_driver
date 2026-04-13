import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class HomeBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 68.h,
        width: double.infinity,
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
          Expanded(child: _buildNavItem(0, 'assets/images/nav_home.png', 'Home', top: 17.h, left: 24.w, isImage: true)),
          Expanded(child: _buildNavItem(1, Icons.map_outlined, 'Map', top: 15.h, left: 25.w)),
          Expanded(child: _buildNavItem(2, 'assets/images/nav_delivery.png', 'Delivery', top: 15.h, left: 25.w, isImage: true)),
          Expanded(child: _buildNavItem(3, 'assets/images/nav_more.png', 'More', top: 15.5.h, left: 21.w, isImage: true)),
        ],
      ),
    ),
  );
}

  Widget _buildNavItem(
    int index,
    dynamic iconOrPath,
    String label, {
    required double top,
    required double left,
    bool isImage = false,
  }) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
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
      ),
    );
  }
}
