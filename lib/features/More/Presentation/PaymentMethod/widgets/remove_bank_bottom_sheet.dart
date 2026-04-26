import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RemoveBankBottomSheet extends StatelessWidget {
  final String accountNumberEnding;
  final VoidCallback onConfirm;

  const RemoveBankBottomSheet({
    super.key,
    required this.accountNumberEnding,
    required this.onConfirm,
  });

  static void show(BuildContext context, {
    required String accountNumberEnding,
    required VoidCallback onConfirm,
  }) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (_) => RemoveBankBottomSheet(
        accountNumberEnding: accountNumberEnding,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: const Color(0xFFDDDDDD),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Do you want to remove this\nbank account',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E1E1E),
                fontFamily: 'Inter',
                height: 1.3,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              'Account number ending with $accountNumberEnding',
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF666666),
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                // No button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1E1E1E),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Yes Remove button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Account removed (not permanent)')),
                      );
                      onConfirm();
                    },
                    child: Container(
                      height: 56.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7D33),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          'Yes Remove',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
