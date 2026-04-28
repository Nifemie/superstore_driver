import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/features/Delivery/Presentation/screens/delivery_summary_screen.dart';

class PackageDeliveredSheet extends StatelessWidget {
  final VoidCallback? onNewDelivery;
  final VoidCallback? onDeliverySummary;

  const PackageDeliveredSheet({
    super.key,
    this.onNewDelivery,
    this.onDeliverySummary,
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

          SizedBox(height: 32.h),

          // Green Checkmark Icon
          Container(
            width: 80.w,
            height: 80.w,
            decoration: BoxDecoration(
              color: const Color(0xFF3DA755).withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: const Color(0xFF3DA755),
              size: 48.r,
            ),
          ),

          SizedBox(height: 24.h),

          // Title
          Text(
            'Package delivered',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E1E1E),
              fontFamily: 'Inter',
            ),
          ),

          SizedBox(height: 40.h),

          // Two Buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                // New Delivery Button (outlined)
                Expanded(
                  child: OutlinedButton(
                    onPressed: onNewDelivery,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFE0E0E0),
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                    ),
                    child: Text(
                      'New delivery',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1E1E1E),
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Delivery Summary Button (filled orange)
                Expanded(
                  child: ElevatedButton(
                    onPressed: onDeliverySummary,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7D33),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      elevation: 0,
                    ),
                    child: Text(
                      'Delivery Summary',
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
}
