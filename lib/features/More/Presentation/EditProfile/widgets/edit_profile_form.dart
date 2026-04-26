import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:superstore_driver/controllers/register_controller.dart';
import 'package:superstore_driver/core/widgets/app_text_field.dart';

class EditProfileForm extends ConsumerStatefulWidget {
  const EditProfileForm({super.key});

  @override
  ConsumerState<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<EditProfileForm> {
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _initControllers(RegisterState state) {
    if (!_initialized) {
      _emailController.text = state.email;
      _phoneController.text = state.phone;
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(registerControllerProvider);
    _initControllers(state);

    final fullName = '${state.firstName} ${state.lastName}'.trim();
    final gender = state.gender;
    final dob = state.dob != null ? DateFormat('dd-MM-yyyy').format(state.dob!) : '';

    return Column(
      children: [
        AppTextField(
          label: 'Full name',
          hintText: 'Full name',
          initialValue: fullName.isNotEmpty ? fullName : 'John Doe',
          readOnly: true,
          showCheckMark: true,
        ),
        SizedBox(height: 20.h),
        AppTextField(
          label: 'Email address',
          hintText: 'Email address',
          controller: _emailController,
          showCheckMark: false,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            ref.read(registerControllerProvider.notifier).updateField(email: value);
          },
        ),
        SizedBox(height: 20.h),
        AppTextField(
          label: 'Phone number',
          hintText: 'Phone number',
          controller: _phoneController,
          showCheckMark: false,
          keyboardType: TextInputType.phone,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (value) {
            ref.read(registerControllerProvider.notifier).updateField(phone: value);
          },
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            Expanded(
              child: AppTextField(
                label: 'Gender',
                hintText: 'Gender',
                initialValue: gender.isNotEmpty ? gender : 'Male',
                readOnly: true,
                showCheckMark: true,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: AppTextField(
                label: 'Date of birth',
                hintText: 'Date of birth',
                initialValue: dob.isNotEmpty ? dob : '10-02-1995',
                readOnly: true,
                showCheckMark: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
