import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/routes/app_routes.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              Text(
                'More',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter',
                  color: const Color(0xFF1E1E1E),
                ),
              ),
              SizedBox(height: 32.h),
              GestureDetector(
                onTap: () => context.push(AppRoutes.accountDetails),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30.r,
                        backgroundImage: const AssetImage('assets/images/driver_profile.png'),
                      ),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My account',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF666666),
                              fontFamily: 'Inter',
                            ),
                          ),
                          Text(
                            'Edward Makarov',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF1E1E1E),
                              fontFamily: 'Inter',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              // Menu Items
              _buildMenuItem(
                icon: Icons.credit_card_outlined,
                title: 'Bank account',
                onTap: () => context.push(AppRoutes.paymentMethod),
              ),
              _buildMenuItem(
                icon: Icons.vpn_key_outlined,
                title: 'Login & Security',
                onTap: () => context.push(AppRoutes.security),
              ),
              _buildMenuItem(
                icon: Icons.description_outlined,
                title: 'Documents',
                onTap: () => context.push(AppRoutes.verificationDocuments),
              ),
              _buildMenuItem(
                icon: Icons.headset_mic_outlined,
                title: 'Support',
                onTap: () => context.push(AppRoutes.support),
              ),
              _buildMenuItem(
                icon: Icons.policy_outlined,
                title: 'Privacy policy',
                onTap: () => context.push(AppRoutes.privacyPolicy),
              ),
              const Spacer(),
              // Log Out Button
              Container(
                width: double.infinity,
                height: 56.h,
                margin: EdgeInsets.only(bottom: 24.h),
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFFF1F1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: const Color(0xFFFF4B4B),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Log Out',
                        style: TextStyle(
                          color: const Color(0xFFFF4B4B),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.r),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF7ED),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                icon,
                color: const Color(0xFFFF7D33),
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              title,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E1E1E),
                fontFamily: 'Inter',
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: const Color(0xFF1E1E1E),
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
