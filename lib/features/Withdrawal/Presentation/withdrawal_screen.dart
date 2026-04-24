import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/controllers/withdrawal_controller.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/features/Withdrawal/Presentation/widgets/withdrawal_appbar.dart';
import 'package:superstore_driver/features/Withdrawal/Presentation/withdrawal_balance_card.dart';
import 'package:superstore_driver/features/Withdrawal/Presentation/widgets/withdrawal_keypad.dart';

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
              const Spacer(),
              PrimaryButton(
                text: 'Withdraw',
                onPressed: withdrawalState.amountValue > 0 
                  ? () {
                      // Implementation for actual withdrawal would go here
                    }
                  : null,
              ),
              SizedBox(height: 48.h),
              const WithdrawalKeypad(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
