import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/routes/app_routes.dart';

enum ReviewStatus { rejected, underReview, approved }

class UnderReviewScreen extends StatelessWidget {
  const UnderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 60.h),
              Center(
                child: Image.asset(
                  'assets/images/under_review.png',
                  height: 140.h,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.folder_shared,
                    size: 100.r,
                    color: AppColors.primary.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Your Submission is under Review',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'We are currently reviewing your submission we will get back to you shortly',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  height: 1.5,
                ),
              ),
              SizedBox(height: 48.h),
              _buildReviewItem(
                iconWidget: Icon(Icons.directions_car_filled_outlined, color: AppColors.primary, size: 24.r),
                title: 'Rider verification',
                status: ReviewStatus.underReview,
              ),
              SizedBox(height: 16.h),
              _buildReviewItem(
                iconWidget: Image.asset(
                  'assets/images/business_verify_icon.png',
                  height: 24.r,
                  width: 24.r,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.business_center_outlined,
                    color: AppColors.primary,
                    size: 24.r,
                  ),
                ),
                title: 'Business verification',
                status: ReviewStatus.underReview,
              ),
              SizedBox(height: 16.h),
              _buildReviewItem(
                icon: Icons.account_balance_outlined,
                title: 'Bank Account',
                status: ReviewStatus.underReview,
              ),
              SizedBox(height: 80.h),
              PrimaryButton(
                text: 'Done',
                onPressed: () {
                  context.go(AppRoutes.home);
                },
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReviewItem({
    IconData? icon,
    Widget? iconWidget,
    required String title,
    required ReviewStatus status,
  }) {
    final statusText = status == ReviewStatus.rejected
        ? 'Rejected'
        : status == ReviewStatus.approved
            ? 'Approved'
            : 'Under Review';

    final statusColor = status == ReviewStatus.rejected
        ? const Color(0xFFE53935)
        : status == ReviewStatus.approved
            ? const Color(0xFF43A047)
            : const Color(0xFFC17E1D);

    final trailingIcon = status == ReviewStatus.rejected
        ? Icons.cancel
        : status == ReviewStatus.approved
            ? Icons.check_circle
            : Icons.more_horiz;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: const Color(0xFFFFF4E8),
              shape: BoxShape.circle,
            ),
            child: iconWidget ?? Icon(icon, color: AppColors.primary, size: 24.r),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Inter',
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  statusText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
