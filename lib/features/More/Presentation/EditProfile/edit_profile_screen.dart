import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/edit_profile_header.dart';
import 'widgets/edit_profile_form.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                const EditProfileHeader(),
                SizedBox(height: 48.h),
                const EditProfileForm(),
                SizedBox(height: 32.h),
                // Info Box
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF7ED),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'You can only change your email and phone number the rest are already verified with your identity document',
                    style: TextStyle(
                      color: const Color(0xFFD97706),
                      fontSize: 14.sp,
                      fontFamily: 'Inter',
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 48.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
