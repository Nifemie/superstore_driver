import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/utils/currency_formatter.dart';
import 'package:superstore_driver/core/widgets/transaction_item.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Transactions',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.h),
          child: Container(color: AppColors.divider, height: 1.h),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            padding: EdgeInsets.only(bottom: 100.h),
            children: [
              _buildDateSection('Sat, 10 Mar'),
              const TransactionItem(title: 'Money withdrawn', date: '10 Feb, 2024 - 4:13pm', amount: '-₦ 10,000', isDebit: true),
              const TransactionItem(title: 'Money withdrawn', date: '10 Feb, 2024 - 4:13pm', amount: '-₦ 10,000', isDebit: true),
              const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
              const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
              const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
              const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
              
              _buildDateSection('Fri, 9 Mar'),
              const TransactionItem(title: 'Money withdrawn', date: '10 Feb, 2024 - 4:13pm', amount: '-₦ 10,000', isDebit: true),
              const TransactionItem(title: 'Money withdrawn', date: '10 Feb, 2024 - 4:13pm', amount: '-₦ 10,000', isDebit: true),
              const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
              const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
              const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
              const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
              
              _buildDateSection('Fri, 8 Mar'),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: Center(
                  child: Text(
                    'No activity Today',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white, size: 18.r),
                    SizedBox(width: 8.w),
                    Text(
                      'Mar 2021',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSection(String date) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      color: const Color(0xFFF8F9FB),
      child: Text(
        date,
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 15.sp,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
      ),
    );
  }


}
