import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

class AppTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Color? suffixIconColor;
  final TextInputType? keyboardType;
  final bool isPassword;
  final String? initialValue;
  final int? maxLines;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool showCheckMark;
  final TextEditingController? controller;
  final bool readOnly;
  final VoidCallback? onTap;
  final List<TextInputFormatter>? inputFormatters;

  const AppTextField({
    super.key,
    this.label = '',
    required this.hintText,
    this.initialValue,
    this.maxLines = 1,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixIconColor,
    this.keyboardType,
    this.isPassword = false,
    this.onChanged,
    this.errorText,
    this.showCheckMark = false,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: 8.h),
        ],
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          maxLines: maxLines,
          keyboardType: keyboardType,
          obscureText: isPassword,
          readOnly: readOnly,
          onTap: onTap,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          style: Theme.of(context).textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: hintText,
            errorText: errorText,
            hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.textSecondary.withOpacity(0.5),
                ),
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: AppColors.textSecondary) : null,
            suffixIcon: showCheckMark
                ? Icon(Icons.check_circle, color: const Color(0xFF4CAF50), size: 24.r)
                : (suffixIcon != null ? Icon(suffixIcon, color: suffixIconColor ?? AppColors.textSecondary) : null),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
