import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConfirmPickupSheet extends StatefulWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

  const ConfirmPickupSheet({
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  State<ConfirmPickupSheet> createState() => _ConfirmPickupSheetState();
}

class _ConfirmPickupSheetState extends State<ConfirmPickupSheet> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              SizedBox(height: 24.h),

              // Title
              Text(
                'Confirm pickup',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E1E1E),
                  fontFamily: 'Inter',
                ),
              ),

              SizedBox(height: 4.h),

              // Subtitle
              Text(
                'Picking up order',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF666666),
                  fontFamily: 'Inter',
                ),
              ),

              SizedBox(height: 24.h),

              // Pickup Code Section
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup code',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF666666),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextField(
                      controller: _codeController,
                      decoration: InputDecoration(
                        hintText: 'Enter pickup code',
                        hintStyle: TextStyle(
                          fontSize: 16.sp,
                          color: const Color(0xFFBDBDBD),
                          fontFamily: 'Inter',
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: const Color(0xFF1E1E1E),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    
                    // Pickup Point
                    _buildLocationRow(
                      icon: Icons.circle,
                      iconColor: const Color(0xFF2196F3),
                      label: 'Pickup point',
                      address: 'Jujin Labu, Janbulo, Kano state',
                      rightLabel: 'Distance',
                      rightValue: '12KM',
                    ),

                    SizedBox(height: 16.h),

                    // Destination
                    _buildLocationRow(
                      icon: Icons.location_on,
                      iconColor: const Color(0xFFFF7D33),
                      label: 'Destination',
                      address: '62 Hawan Dawaki Kano state',
                      rightLabel: 'Estimated pay',
                      rightValue: 'N 2000',
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Buttons
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    // Cancel Button
                    Expanded(
                      child: OutlinedButton(
                        onPressed: widget.onCancel,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xFFFF4B4B),
                            width: 2,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFF4B4B),
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 12.w),

                    // Confirm Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: widget.onConfirm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7D33),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          elevation: 0,
                        ),
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String address,
    required String rightLabel,
    required String rightValue,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Icon
        Container(
          width: 40.w,
          height: 40.w,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20.sp,
          ),
        ),

        SizedBox(width: 12.w),

        // Address Section
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF999999),
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                address,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E1E1E),
                  fontFamily: 'Inter',
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: 12.w),

        // Right Info
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              rightLabel,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF999999),
                fontFamily: 'Inter',
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              rightValue,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1E1E1E),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
