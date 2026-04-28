import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/features/Delivery/Presentation/widgets/delivery_history_item.dart';

class DeliveryHistoryList extends StatelessWidget {
  const DeliveryHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      children: [
        // Sat, 10 Mar section
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Text(
              'Sat, 10 Mar',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF999999),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: true,
              ),
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: true,
              ),
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: true,
              ),
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: true,
              ),
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: false,
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // Fri, 9 Mar section
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Text(
              'Fri, 9 Mar',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF999999),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            children: [
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: true,
              ),
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: true,
              ),
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: true,
              ),
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: true,
              ),
              DeliveryHistoryItem(
                title: 'Delivery earnings',
                date: '10 Feb, 2024 - 4:13pm',
                amount: '+N 2000',
                showDivider: false,
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // Fri, 8 Mar section
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: Text(
              'Fri, 8 Mar',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF999999),
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        Center(
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 16.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              color: const Color(0xFFFF7D33),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Text(
              'Mar 2021',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                fontFamily: 'Inter',
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            'No activity Today',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: const Color(0xFF999999),
              fontFamily: 'Inter',
            ),
          ),
        ),
        SizedBox(height: 32.h),
      ],
    );
  }
}
