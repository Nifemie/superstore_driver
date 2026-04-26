import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/routes/app_routes.dart';
import 'widgets/bank_item.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24),
                      onPressed: () => context.pop(),
                    ),
                  ),
                  Text(
                    'Payment method',
                    style: TextStyle(
                      color: const Color(0xFF1E1E1E),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Inter',
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    // Preferred Payout Method
                    Text(
                      'Preferred Payout Method',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    BankItem(
                      name: 'John Doe',
                      accountNumber: '123910138389',
                      bankName: 'United bank of Africa',
                      onTap: () => context.push(AppRoutes.bankDetail),
                    ),
                    SizedBox(height: 24.h),
                    // Other Payment Method
                    Text(
                      'Other payment Method',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E1E1E),
                        fontFamily: 'Inter',
                      ),
                    ),
                    SizedBox(height: 16.h),
                    BankItem(
                      name: 'John Doe',
                      accountNumber: '123910138389',
                      bankName: 'United bank of Africa',
                      onTap: () => context.push(AppRoutes.bankDetail),
                    ),
                    Divider(color: const Color(0xFFEEEEEE), height: 1.h),
                    BankItem(
                      name: 'John Doe',
                      accountNumber: '123910138389',
                      bankName: 'United bank of Africa',
                      onTap: () => context.push(AppRoutes.bankDetail),
                    ),
                    const Spacer(),
                    // Add New Bank Button
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      margin: EdgeInsets.only(bottom: 24.h),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFEEEEEE)),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextButton(
                        onPressed: () => context.push(AppRoutes.addBank),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: const Color(0xFFFF7D33),
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Add New Bank',
                              style: TextStyle(
                                color: const Color(0xFFFF7D33),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
