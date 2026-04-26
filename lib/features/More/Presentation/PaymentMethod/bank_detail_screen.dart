import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'widgets/bank_detail_card.dart';
import 'widgets/default_payout_toggle.dart';
import 'widgets/remove_bank_bottom_sheet.dart';

class BankDetailScreen extends StatefulWidget {
  const BankDetailScreen({super.key});

  @override
  State<BankDetailScreen> createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  bool _isDefault = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24),
          onPressed: () => context.pop(),
        ),
        title: Text(
          'Payment method',
          style: TextStyle(
            color: const Color(0xFF1E1E1E),
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            fontFamily: 'Inter',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 24.h),
                    const BankDetailCard(
                      label: 'Account holder name',
                      value: 'John Doe',
                    ),
                    SizedBox(height: 12.h),
                    const BankDetailCard(
                      label: 'Bank Name',
                      value: 'United Bank of Africa',
                    ),
                    SizedBox(height: 12.h),
                    const BankDetailCard(
                      label: 'Account number',
                      value: '1267891001',
                    ),
                    SizedBox(height: 16.h),
                    // Default toggle
                    DefaultPayoutToggle(
                      value: _isDefault,
                      onChanged: (value) {
                        setState(() {
                          _isDefault = value;
                        });
                      },
                    ),
                    const Spacer(),
                    // Remove Bank Button
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      margin: EdgeInsets.only(bottom: 24.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFD32F2F)),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextButton(
                        onPressed: () {
                          RemoveBankBottomSheet.show(
                            context,
                            accountNumberEnding: '1001',
                            onConfirm: () {
                              context.pop();
                            },
                          );
                        },
                        child: Text(
                          'Remove Bank',
                          style: TextStyle(
                            color: const Color(0xFFD32F2F),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
