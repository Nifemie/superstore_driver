import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:superstore_driver/controllers/verification_controller.dart';
import 'package:superstore_driver/core/widgets/custom_numeric_keypad.dart';

class VerificationKeypad extends ConsumerWidget {
  const VerificationKeypad({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logic = ref.read(verificationControllerProvider.notifier);

    return CustomNumericKeypad(
      onDigitPressed: (digit) => logic.addDigit(digit),
      onDeletePressed: () => logic.removeDigit(),
    );
  }
}
