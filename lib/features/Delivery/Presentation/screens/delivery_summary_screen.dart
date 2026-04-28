import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/features/Delivery/Presentation/widgets/delivery_summary_header.dart';
import 'package:superstore_driver/features/Delivery/Presentation/widgets/delivery_summary_map.dart';
import 'package:superstore_driver/features/Delivery/Presentation/widgets/delivery_summary_stats.dart';
import 'package:superstore_driver/features/Delivery/Presentation/widgets/delivery_summary_details.dart';
import 'package:superstore_driver/features/Delivery/Presentation/widgets/delivery_summary_transaction.dart';

class DeliverySummaryScreen extends StatelessWidget {
  const DeliverySummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const DeliverySummaryHeader(),
            const DeliverySummaryMap(),
            const DeliverySummaryStats(),
            const DeliverySummaryDetails(),
            const DeliverySummaryTransaction(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Reset the delivery state when continuing
                    // This will be handled by the calling context
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF7D33),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
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
          ],
        ),
      ),
    );
  }
}
