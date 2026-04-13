import 'package:go_router/go_router.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/transaction_item.dart';
import 'package:superstore_driver/features/Transactions/Logic/transaction_logic.dart';
import 'package:superstore_driver/features/Transactions/Presentation/widgets/month_year_picker_dialog.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  void _showPicker(BuildContext context, WidgetRef ref, DateTime? initialDate) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (context, anim1, anim2) {
        return MonthYearPickerDialog(
          initialDate: initialDate ?? DateTime.now(),
          onDone: (month, year) {
            ref.read(transactionLogicProvider.notifier).updateDate(month, year);
          },
        );
      },

      transitionBuilder: (context, anim1, anim2, child) {
        return FadeTransition(
          opacity: anim1,
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionLogicProvider);
    final filtered = state.filteredTransactions;
    
    // Group transactions by date for headers
    final grouped = groupBy(filtered, (t) => t.sectionHeader);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
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
          if (filtered.isEmpty)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Icon(Icons.history, color: AppColors.grey, size: 64.r),
                   SizedBox(height: 16.h),
                   Text(
                    'No activities for ${state.formattedDate}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16.sp,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            )
          else
            ListView.builder(
              padding: EdgeInsets.only(bottom: 100.h),
              itemCount: grouped.length,
              itemBuilder: (context, index) {
                final dateHeader = grouped.keys.elementAt(index);
                final transactions = grouped[dateHeader]!;
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateSection(dateHeader),
                    ...transactions.map((t) => TransactionItem(
                      title: t.title,
                      date: t.formattedDate,
                      amount: t.amount,
                      isDebit: t.isDebit,
                    )),
                  ],
                );
              },
            ),
          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: () => _showPicker(context, ref, state.selectedDate),
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
                        state.formattedDate,
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
