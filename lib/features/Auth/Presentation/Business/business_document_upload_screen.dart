import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import '../../Logic/register_logic.dart';
import '../Register/widgets/registration_tabs.dart';
import 'package:superstore_driver/routes/app_routes.dart';

class BusinessDocumentUploadScreen extends ConsumerWidget {
  const BusinessDocumentUploadScreen({super.key});

  void _simulateUpload(WidgetRef ref) {
    ref.read(registerLogicProvider.notifier).updateBusinessDocument('Business document.PDF');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerLogicProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, top: 16.h, right: 24.w),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                            onPressed: () => Navigator.pop(context),
                          ),
                          Center(
                            child: Text(
                              'Riders registration',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: const RegistrationTabs(activeIndex: 1),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.h),
                            Text(
                              'Upload business document',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                height: 1.0,
                                letterSpacing: 0,
                              ),
                            ),
                            SizedBox(height: 32.h),
                            _buildUploadBox(context, ref),
                            if (state.businessDocumentPath.isNotEmpty) ...[
                              SizedBox(height: 16.h),
                              _buildFileItem(state.businessDocumentPath),
                            ],
                            SizedBox(height: 100.h),
                            PrimaryButton(
                              text: 'Next',
                              onPressed: state.businessDocumentPath.isNotEmpty
                                  ? () {
                                      Navigator.pushNamed(context, AppRoutes.bankDetails);
                                    }
                                  : null,
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBox(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => _simulateUpload(ref),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 40.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: Colors.grey.withOpacity(0.3),
            style: BorderStyle.solid,
          ),
        ),
        child: Column(
          children: [
            Icon(Icons.cloud_upload_outlined, size: 36.r, color: AppColors.primary),
            SizedBox(height: 16.h),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                children: [
                  TextSpan(
                    text: 'Click to upload ',
                    style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                  const TextSpan(text: 'business document'),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'PDF, JPG or JPEG (Max 25MB)',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey.withOpacity(0.7)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileItem(String fileName) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.picture_as_pdf, color: Colors.red, size: 24.r),
          ),
          SizedBox(width: 12.h),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: Colors.black),
                ),
                Text(
                  '2MB',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
