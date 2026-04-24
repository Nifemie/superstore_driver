import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';

class WithdrawalAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WithdrawalAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Color(0xFF1E1E1E), size: 24),
        onPressed: () => context.pop(),
      ),
      title: Text(
        'Withdraw earnings',
        style: TextStyle(
          color: const Color(0xFF1E1E1E),
          fontSize: 18.sp,
          fontWeight: FontWeight.w700,
          fontFamily: 'Inter',
        ),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
