import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrivedSheet extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onConfirmArrival;

  const ArrivedSheet({
    super.key,
    required this.onCancel,
    required this.onConfirmArrival,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            'Arrived',
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

          // Pickup and Destination Container
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              children: [
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
                    onPressed: onCancel,
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

                // Confirm Arrival Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirmArrival,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7D33),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'Confirm arrival',
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
