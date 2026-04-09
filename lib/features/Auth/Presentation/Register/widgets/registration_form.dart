import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nigeria_lg_state_city/const.dart' as location;
import 'package:nigeria_lg_state_city/nigeria_lg_state_city.dart' as pkg;
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/app_text_field.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/features/Auth/Logic/register_logic.dart';
import 'package:superstore_driver/features/Auth/Presentation/Register/widgets/registration_widgets.dart';

class RegistrationForm extends ConsumerStatefulWidget {
  const RegistrationForm({super.key});
  @override
  ConsumerState<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends ConsumerState<RegistrationForm> {
  final _locationController = location.StateLgaCityController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  bool _isFormValid(RegisterState state) {
    return state.firstName.isNotEmpty &&
        state.lastName.isNotEmpty &&
        state.gender.isNotEmpty &&
        state.dob != null &&
        state.email.contains('@') &&
        state.phone.length >= 10 &&
        state.residentState.isNotEmpty &&
        state.city.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerLogicProvider);
    final logic = ref.read(registerLogicProvider.notifier);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'First Name',
                hintText: 'e.g. John',
                showCheckMark: false,
                onChanged: (v) => logic.updateField(firstName: v),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: AppTextField(
                label: 'Last Name',
                hintText: 'e.g. Doe',
                showCheckMark: false,
                onChanged: (v) => logic.updateField(lastName: v),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _CustomDropdown(
                label: 'Gender',
                value: state.gender.isEmpty ? null : state.gender,
                items: ['Male', 'Female', 'Other'],
                showCheckMark: state.gender.isNotEmpty,
                onChanged: (v) => logic.updateField(gender: v),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: _PickerField(
                label: 'Date of birth',
                value: state.dob == null ? '' : state.dob.toString().split(' ')[0],
                showCheckMark: state.dob != null,
                onTap: () => _showDatePicker(context, logic),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        AppTextField(
          label: 'Email address',
          hintText: 'Enter email',
          prefixIcon: Icons.email_outlined,
          showCheckMark: false, // Strictly removed as requested
          onChanged: (v) => logic.updateField(email: v),
        ),
        SizedBox(height: 16.h),
        PhoneField(
          showCheckMark: state.phone.length >= 10,
          onChanged: (v) => logic.updateField(phone: v),
        ),
        SizedBox(height: 16.h),
        pkg.NigeriaStateDropdown(
          controller: _locationController,
          decoration: _dropdownDecoration('State'),
          onChanged: (v) => logic.updateField(residentState: _locationController.selectedState?['name'] ?? ''),
        ),
        SizedBox(height: 16.h),
        pkg.NigeriaCityDropdown(
          controller: _locationController,
          decoration: _dropdownDecoration('City'),
          onChanged: (v) => logic.updateField(city: _locationController.selectedCity?['name'] ?? ''),
        ),
        SizedBox(height: 32.h),
        PrimaryButton(
          text: 'Next',
          isLoading: state.isLoading,
          onPressed: _isFormValid(state) ? () => logic.submit(context) : null,
        ),
        SizedBox(height: 24.h),
        const FooterText(),
      ],
    );
  }

  InputDecoration _dropdownDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.divider)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
    );
  }

  void _showDatePicker(BuildContext context, RegisterLogic logic) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (date != null) logic.updateField(dob: date);
  }
}

class _CustomDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final bool showCheckMark;

  const _CustomDropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
    required this.showCheckMark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
        SizedBox(height: 8.h),
        DropdownButtonFormField<String>(
          value: value,
          icon: showCheckMark ? Text('✅', style: TextStyle(fontSize: 14.sp)) : const Icon(Icons.arrow_drop_down),
          decoration: InputDecoration(
            hintText: 'Choose',
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.divider)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
          ),
          items: items.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _PickerField extends StatelessWidget {
  final String label, value;
  final VoidCallback onTap;
  final bool showCheckMark;

  const _PickerField({required this.label, required this.value, required this.onTap, required this.showCheckMark});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
        SizedBox(height: 8.h),
        InkWell(
          onTap: onTap,
          child: Container(
            height: 52.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.divider),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    value.isEmpty ? 'Choose' : value,
                    style: TextStyle(color: value.isEmpty ? AppColors.textSecondary : Colors.black),
                  ),
                ),
                if (showCheckMark)
                  Text('✅', style: TextStyle(fontSize: 14.sp))
                else
                  Icon(Icons.calendar_today_outlined, size: 18.r, color: AppColors.textSecondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
