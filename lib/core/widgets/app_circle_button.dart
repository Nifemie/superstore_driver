import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class AppCircleButton extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback onTap;
  final Color? iconColor;

  const AppCircleButton({
    super.key,
    this.text,
    this.icon,
    required this.onTap,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          onTap();
        },
        customBorder: const CircleBorder(),
        child: Container(
          height: 64.r, // Reduced from 80.r for better fit
          width: 64.r, // Reduced from 80.r for better fit
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.divider.withOpacity(0.8), // Increased opacity for visibility
              width: 1.5, // Increased width for better definition
            ),
          ),
          alignment: Alignment.center,
          child: icon != null
              ? Icon(
                  icon,
                  color: iconColor ?? Colors.black,
                  size: 28.r,
                )
              : Text(
                  text ?? '',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
        ),
      ),
    );
  }
}
