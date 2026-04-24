import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/controllers/withdrawal_controller.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/features/Withdrawal/Presentation/widgets/withdrawal_appbar.dart';
import 'package:superstore_driver/features/Withdrawal/Presentation/withdrawal_balance_card.dart';
import 'package:superstore_driver/features/Withdrawal/Presentation/widgets/withdrawal_keypad.dart';
import 'package:superstore_driver/routes/app_routes.dart';

class WithdrawalScreen extends ConsumerWidget {
  const WithdrawalScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final withdrawalState = ref.watch(withdrawalControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const WithdrawalAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              const WithdrawalBalanceCard(),
              SizedBox(height: 32.h),
              PrimaryButton(
                text: 'Withdraw',
                onPressed: withdrawalState.amountValue > 0 
                  ? () => context.push(AppRoutes.withdrawalVerification)
                  : null,
              ),
              SizedBox(height: 32.h),
              const WithdrawalKeypad(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
