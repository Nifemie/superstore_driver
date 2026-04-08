import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';
import '../../Logic/register_logic.dart';

class IdentityVerificationScreen extends ConsumerWidget {
  const IdentityVerificationScreen({super.key});

  Future<void> _pickImage(WidgetRef ref) async {
    // Dummy logic for testing without actual camera access
    ref.read(registerLogicProvider.notifier).updateIdentityDocument('dummy_captured');
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
                      child: const _RegistrationTabs(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Take a photo of your identity document',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                height: 1.0,
                                letterSpacing: 0,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              state.identityDocumentPath.isEmpty
                                  ? 'National ID card, Drivers license and international passport are accepted for the verification'
                                  : 'Submit this image if you feel its readable or click on retake to try again',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    height: 1.4,
                                  ),
                            ),
                            SizedBox(height: 32.h),
                            _buildIDPreview(state.identityDocumentPath),
                            SizedBox(height: 24.h),
                            if (state.identityDocumentPath.isEmpty) ...[
                              Center(
                                child: Text(
                                  'Position your ID within the frame, make sure your are in an environment where there is enough light',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13.sp,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              SizedBox(height: 40.h),
                              Center(
                                child: _CaptureButton(
                                  onTap: () => _pickImage(ref),
                                ),
                              ),
                            ] else ...[
                              Row(
                                children: [
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () => ref.read(registerLogicProvider.notifier).updateIdentityDocument(''),
                                      style: OutlinedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(vertical: 16.h),
                                        side: BorderSide(color: Colors.grey.shade300),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                      ),
                                      child: Text(
                                        'Retake',
                                        style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Next step or confirmation
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        padding: EdgeInsets.symmetric(vertical: 16.h),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                                        elevation: 0,
                                      ),
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            SizedBox(height: 40.h),
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

  Widget _buildIDPreview(String path) {
    return Container(
      width: double.infinity,
      height: 240.h,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(16.r),
        image: path.isEmpty
            ? const DecorationImage(
                image: AssetImage('assets/images/id_placeholder.png'),
                fit: BoxFit.cover,
              )
            : path == 'dummy_captured'
                ? const DecorationImage(
                    image: AssetImage('assets/images/id_placeholder_2.png'),
                    fit: BoxFit.cover,
                  )
                : DecorationImage(
                    image: FileImage(File(path)),
                    fit: BoxFit.cover,
                  ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.black.withOpacity(0.05),
        ),
      ),
    );
  }
}

class _RegistrationTabs extends StatelessWidget {
  const _RegistrationTabs();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab('Rider verification', true),
        SizedBox(width: 8.w),
        _buildTab('Business registration', false),
        SizedBox(width: 8.w),
        _buildTab('Bank details', false),
      ],
    );
  }

  Widget _buildTab(String label, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              height: 1.0,
              letterSpacing: 0,
              color: isActive ? AppColors.primary : AppColors.textSecondary.withOpacity(0.6),
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 3.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isActive ? AppColors.primary : AppColors.divider.withOpacity(0.5),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }
}

class _CaptureButton extends StatelessWidget {
  final VoidCallback onTap;
  const _CaptureButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(6.r),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.primary.withOpacity(0.3), width: 3),
            ),
            child: Container(
              height: 70.r,
              width: 70.r,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
        SizedBox(height: 12.h),
        Text(
          'Capture',
          style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600, color: AppColors.textSecondary),
        ),
      ],
    );
  }
}
