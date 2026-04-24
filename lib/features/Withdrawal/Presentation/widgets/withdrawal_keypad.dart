import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/controllers/withdrawal_controller.dart';
import 'package:superstore_driver/core/widgets/app_circle_button.dart';

class WithdrawalKeypad extends ConsumerWidget {
  const WithdrawalKeypad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logic = ref.read(withdrawalControllerProvider.notifier);

    return Column(
      children: [
        _buildRow(ref, ['1', '2', '3']),
        SizedBox(height: 16.h),
        _buildRow(ref, ['4', '5', '6']),
        SizedBox(height: 16.h),
        _buildRow(ref, ['7', '8', '9']),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 64.r, height: 64.r), // Empty space
            AppCircleButton(
              text: '0',
              onTap: () => logic.addDigit('0'),
            ),
            AppCircleButton(
              icon: Icons.backspace_outlined,
              iconColor: Colors.redAccent,
              onTap: () => logic.removeDigit(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(WidgetRef ref, List<String> digits) {
    final logic = ref.read(withdrawalControllerProvider.notifier);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: digits.map((d) => AppCircleButton(
        text: d,
        onTap: () => logic.addDigit(d),
      )).toList(),
    );
  }
}
