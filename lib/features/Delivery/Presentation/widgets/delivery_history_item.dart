import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/features/Delivery/Presentation/screens/delivery_summary_screen.dart';

class DeliveryHistoryItem extends StatelessWidget {
  final String title;
  final String date;
  final String amount;
  final bool showDivider;
  final VoidCallback? onTap;

  const DeliveryHistoryItem({
    super.key,
    required this.title,
    required this.date,
    required this.amount,
    this.showDivider = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DeliverySummaryScreen(),
          ),
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Row(
          children: [
            // Icon
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_downward,
                color: const Color(0xFF4CAF50),
                size: 20.r,
              ),
            ),

            SizedBox(width: 12.w),

            // Title and Date
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E1E1E),
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF999999),
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),

            // Amount
            Text(
              amount,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF4CAF50),
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
