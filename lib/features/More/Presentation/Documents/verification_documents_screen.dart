import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'widgets/verification_document_item.dart';

class VerificationDocumentsScreen extends StatelessWidget {
  const VerificationDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  Text(
                    'Verification documents',
                    style: TextStyle(
                      color: const Color(0xFF1E1E1E),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    SizedBox(height: 24.h),
                    const VerificationDocumentItem(
                      icon: Icons.contact_mail_outlined,
                      title: 'Drivers License',
                      status: 'Approved',
                    ),
                    const VerificationDocumentItem(
                      icon: Icons.folder_open_outlined,
                      title: 'Business document',
                      status: 'Approved',
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
}
