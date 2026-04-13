import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/app_text_field.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/routes/app_routes.dart';
import '../../Logic/register_logic.dart';
import 'package:superstore_driver/features/Auth/Presentation/Register/widgets/registration_tabs.dart';

class BusinessVerificationScreen extends ConsumerStatefulWidget {
  const BusinessVerificationScreen({super.key});

  @override
  ConsumerState<BusinessVerificationScreen> createState() => _BusinessVerificationScreenState();
}

class _BusinessVerificationScreenState extends ConsumerState<BusinessVerificationScreen> {


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerLogicProvider);
    final logic = ref.read(registerLogicProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        bottom: true,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.r),
                    topRight: Radius.circular(40.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, top: 16.h, right: 24.w),
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
                            onPressed: () => context.pop(),
                          ),
                          Center(
                            child: Text(
                              'Riders registration',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.sp,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      child: const RegistrationTabs(activeIndex: 1),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 12.h),
                            AppTextField(
                              label: 'Business name',
                              hintText: 'Enter business name',
                              initialValue: state.businessName,
                              onChanged: (v) => logic.updateBusinessFields(businessName: v),
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: AppTextField(
                                    label: 'State',
                                    hintText: 'Enter state',
                                    initialValue: state.businessState,
                                    showCheckMark: false,
                                    onChanged: (v) => logic.updateBusinessFields(businessState: v),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: AppTextField(
                                    label: 'City',
                                    hintText: 'Enter city',
                                    initialValue: state.businessCity,
                                    showCheckMark: false,
                                    onChanged: (v) => logic.updateBusinessFields(businessCity: v),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            AppTextField(
                              label: 'Business address',
                              hintText: 'Enter where your business is located',
                              initialValue: state.businessAddress,
                              maxLines: 5,
                              onChanged: (v) => logic.updateBusinessFields(businessAddress: v),
                            ),
                            SizedBox(height: 40.h),
                            PrimaryButton(
                              text: 'Next',
                              isLoading: state.isLoading,
                              onPressed: _isFormValid(state)
                                  ? () {
                                      context.push(AppRoutes.businessUpload);
                                    }
                                  : null,
                            ),
                            SizedBox(height: 24.h),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }



  bool _isFormValid(RegisterState state) {
    return state.businessName.isNotEmpty &&
        state.businessState.isNotEmpty &&
        state.businessCity.isNotEmpty &&
        state.businessAddress.isNotEmpty;
  }
}
