import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nigeria_lg_state_city/const.dart' as location;
import 'package:nigeria_lg_state_city/nigeria_lg_state_city.dart' as pkg;
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
  final _locationController = location.StateLgaCityController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

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
                            onPressed: () => Navigator.pop(context),
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
                                  child: pkg.NigeriaStateDropdown(
                                    controller: _locationController,
                                    decoration: _dropdownDecoration('State'),
                                    onChanged: (v) {
                                      logic.updateBusinessFields(
                                        businessState: _locationController.selectedState?['name'] ?? '',
                                        businessCity: '', // Reset city on state change
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: pkg.NigeriaCityDropdown(
                                    controller: _locationController,
                                    decoration: _dropdownDecoration('City'),
                                    onChanged: (v) {
                                      logic.updateBusinessFields(
                                        businessCity: _locationController.selectedCity?['name'] ?? '',
                                      );
                                    },
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
                                      Navigator.pushNamed(context, AppRoutes.businessUpload);
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

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 13.sp, fontWeight: FontWeight.w500),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      hintText: 'Choose ${label.toLowerCase()}',
      hintStyle: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 13.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.divider)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
    );
  }

  bool _isFormValid(RegisterState state) {
    return state.businessName.isNotEmpty &&
        state.businessState.isNotEmpty &&
        state.businessCity.isNotEmpty &&
        state.businessAddress.isNotEmpty;
  }
}
