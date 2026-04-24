import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(130.h),
      child: SafeArea(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Centered Profile Picture (Positioned lower)
              Positioned(
                top: 20.h,
                child: CircleAvatar(
                  radius: 50.r,
                  backgroundImage: const AssetImage('assets/images/driver_profile.png'),
                ),
              ),
              // Navigation Row (Back and Edit) - Placed last to be on top for clicks
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
                      onPressed: () => context.pop(),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        children: [
                          Text(
                            'Edit Profile',
                            style: TextStyle(
                              color: const Color(0xFFFF7D33),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: const Color(0xFFFF7D33),
                            size: 14.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(130.h);
}
