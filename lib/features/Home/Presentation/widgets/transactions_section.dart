import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/transaction_item.dart';
import 'package:superstore_driver/routes/app_routes.dart';

class TransactionsSection extends StatelessWidget {
  const TransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Transactions',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                fontFamily: 'Inter',
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, AppRoutes.transactions),
              child: Text(
                'See All',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
              ),
            ),
          ],
        ),
        const TransactionItem(title: 'Money withdrawn', date: '10 Feb, 2024 - 4:13pm', amount: '-₦ 10,000', isDebit: true),
        const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
        const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
        const TransactionItem(title: 'Delivery earnings', date: '10 Feb, 2024 - 4:13pm', amount: '+₦ 2000'),
      ],
    );
  }
}
