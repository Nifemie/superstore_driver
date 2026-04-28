import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/features/Delivery/Presentation/widgets/delivery_history_header.dart';
import 'package:superstore_driver/features/Delivery/Presentation/widgets/delivery_history_list.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: const Color(0xFF1E1E1E),
            size: 24.r,
          ),
        ),
        title: Text(
          'Delivery history',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E1E1E),
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: const DeliveryHistoryList(),
    );
  }
}
