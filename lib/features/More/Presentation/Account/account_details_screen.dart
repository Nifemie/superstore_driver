import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/features/More/Presentation/Account/widgets/account_app_bar.dart';
import 'package:superstore_driver/features/More/Presentation/Account/widgets/trips_stats_card.dart';
import 'package:superstore_driver/features/More/Presentation/Account/widgets/personal_details_section.dart';
import 'package:superstore_driver/features/More/Presentation/Account/widgets/business_details_section.dart';

class AccountDetailsScreen extends StatelessWidget {
  const AccountDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AccountAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 8.h),
              const TripsStatsCard(),
              SizedBox(height: 48.h),
              const PersonalDetailsSection(),
              SizedBox(height: 32.h),
              const BusinessDetailsSection(),
              SizedBox(height: 48.h),
            ],
          ),
        ),
      ),
    );
  }
}
