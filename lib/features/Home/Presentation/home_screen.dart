import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/features/Home/Logic/home_logic.dart';
import 'package:superstore_driver/features/Home/Presentation/widgets/home_header.dart';
import 'package:superstore_driver/features/Home/Presentation/widgets/earnings_card.dart';
import 'package:superstore_driver/features/Home/Presentation/widgets/status_toggle.dart';
import 'package:superstore_driver/features/Home/Presentation/widgets/order_alert.dart';
import 'package:superstore_driver/features/Home/Presentation/widgets/activities_section.dart';
import 'package:superstore_driver/features/Home/Presentation/widgets/transactions_section.dart';
import 'package:superstore_driver/features/Home/Presentation/widgets/home_bottom_nav.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeLogicProvider);
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    const HomeHeader(),
                    SizedBox(height: 24.h),
                    const EarningsCard(),
                    SizedBox(height: 24.h),
                    const StatusToggle(),
                    SizedBox(height: 24.h),
                    const OrderAlert(),
                    SizedBox(height: 32.h),
                    ActivitiesSection(state: homeState),
                    SizedBox(height: 32.h),
                    const TransactionsSection(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            const HomeBottomNav(),
          ],
        ),
      ),
    );
  }
}
