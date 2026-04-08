import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:superstore_driver/core/theme/app_colors.dart';
import 'package:superstore_driver/core/widgets/app_text_field.dart';
import 'package:superstore_driver/core/widgets/primary_button.dart';
import 'package:superstore_driver/core/widgets/social_auth_button.dart';
import 'package:superstore_driver/features/Auth/Logic/login_logic.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const _LoginHeader(),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  const _LoginForm(),
                  SizedBox(height: 24.h),
                  const _SocialSection(),
                  SizedBox(height: 32.h),
                  const _LoginFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoginHeader extends StatelessWidget {
  const _LoginHeader();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.primary,
      padding: EdgeInsets.only(top: 64.h, bottom: 32.h),
      child: Column(
        children: [
          Container(
            height: 90.r,
            width: 90.r,
            padding: EdgeInsets.all(16.r),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Image.asset('assets/icons/logo.png', fit: BoxFit.contain),
          ),
          SizedBox(height: 16.h),
          Text(
            'Welcome to superstore\nrider app',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            'Enter your email to continue',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white.withOpacity(0.9)),
          ),
        ],
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginLogicProvider);
    final logic = ref.read(loginLogicProvider.notifier);
    return Column(
      children: [
        AppTextField(
          label: 'Email Address',
          hintText: 'Johndoe@',
          prefixIcon: Icons.email_outlined,
          onChanged: (val) => logic.onEmailChanged(val),
          errorText: state.errorMessage,
        ),
        SizedBox(height: 24.h),
        PrimaryButton(text: 'Next', onPressed: () => logic.onNextPressed(context)),
      ],
    );
  }
}

class _SocialSection extends ConsumerWidget {
  const _SocialSection();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: AppColors.divider)),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16.w), child: const Text('Or Continue with')),
            const Expanded(child: Divider(color: AppColors.divider)),
          ],
        ),
        SizedBox(height: 24.h),
        SocialAuthButton(
          text: 'Continue with Google',
          iconPath: 'assets/icons/google_logo.png',
          onPressed: () => ref.read(loginLogicProvider.notifier).onSocialLogin('google'),
        ),
        SizedBox(height: 16.h),
        SocialAuthButton(
          text: 'Continue with Apple ID',
          iconPath: 'assets/icons/apple_logo.png',
          onPressed: () => ref.read(loginLogicProvider.notifier).onSocialLogin('apple'),
        ),
      ],
    );
  }
}

class _LoginFooter extends StatelessWidget {
  const _LoginFooter();
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: TextStyle(color: AppColors.textSecondary, fontSize: 14.sp, fontWeight: FontWeight.w500, height: 1.5, fontFamily: 'Inter'),
        children: [
          const TextSpan(text: 'By signing up, you agree to our '),
          TextSpan(text: 'Terms & Conditions', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          const TextSpan(text: ', acknowledging our '),
          TextSpan(text: 'Privacy Policy', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
          const TextSpan(text: ', and confirm that you are above 18.'),
        ],
      ),
    );
  }
}
