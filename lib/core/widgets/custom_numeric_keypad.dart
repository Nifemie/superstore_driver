import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/widgets/app_circle_button.dart';

class CustomNumericKeypad extends StatelessWidget {
  final Function(String) onDigitPressed;
  final VoidCallback onDeletePressed;

  const CustomNumericKeypad({
    super.key,
    required this.onDigitPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(['1', '2', '3']),
        SizedBox(height: 16.h),
        _buildRow(['4', '5', '6']),
        SizedBox(height: 16.h),
        _buildRow(['7', '8', '9']),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 64.r, height: 64.r),
            AppCircleButton(text: '0', onTap: () => onDigitPressed('0')),
            AppCircleButton(
              icon: Icons.backspace_outlined,
              iconColor: Colors.redAccent,
              onTap: onDeletePressed,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<String> keys) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: keys.map((key) => AppCircleButton(
        text: key, 
        onTap: () => onDigitPressed(key),
      )).toList(),
    );
  }
}
