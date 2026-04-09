import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/app_text_field.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import '../../Logic/register_logic.dart';
import '../Register/widgets/registration_tabs.dart';
import 'bank_service.dart';

class BankDetailsScreen extends ConsumerWidget {
  const BankDetailsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                      child: const RegistrationTabs(activeIndex: 2),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 24.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8.h),
                            Text(
                              'Add bank details',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                height: 1.0,
                                letterSpacing: 0,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              'You will be able to withdraw your earning through this bank account',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 13.sp,
                                height: 1.4,
                              ),
                            ),
                            SizedBox(height: 32.h),
                            _buildBankDropdown(context, state, logic),
                            SizedBox(height: 16.h),
                            AppTextField(
                              label: 'Account number',
                              hintText: 'Enter account number',
                              keyboardType: TextInputType.number,
                              initialValue: state.accountNumber,
                              onChanged: (v) => logic.updateBankFields(accountNumber: v),
                            ),
                            SizedBox(height: 16.h),
                            AppTextField(
                              label: 'Account name',
                              hintText: 'Enter account name',
                              initialValue: state.accountName,
                              onChanged: (v) => logic.updateBankFields(accountName: v),
                            ),
                            SizedBox(height: 48.h),
                            PrimaryButton(
                              text: 'Next',
                              isLoading: state.isLoading,
                              onPressed: () {
                                logic.submit(context);
                              },
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

  Widget _buildBankDropdown(BuildContext context, RegisterState state, RegisterLogic logic) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bank name',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
        ),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: state.bankName.isEmpty ? null : state.bankName,
          hint: Text(
            'Choose bank',
            style: TextStyle(color: AppColors.textSecondary.withOpacity(0.5), fontSize: 13.sp),
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.divider),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          items: BankService.nigerianBanks.map((bank) {
            return DropdownMenuItem(
              value: bank.name,
              child: Text(bank.name, style: TextStyle(fontSize: 14.sp)),
            );
          }).toList(),
          onChanged: (v) => logic.updateBankFields(bankName: v),
        ),
      ],
    );
  }

  bool _isFormValid(RegisterState state) {
    return state.bankName.isNotEmpty &&
        state.accountNumber.length == 10 && // NUBAN requirement
        state.accountName.isNotEmpty;
  }
}
