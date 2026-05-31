import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/forgetPassword/manager/resetCubit/reset_password_cubit.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = ResetPasswordCubit.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: const [
          ArrowBackButton(),
          Spacer(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reset Password'.tr(),
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please reset your password'.tr(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: AppColors.textColor,
                      ),
                ),

                // Show the message returned from the forget-password API
                if (cubit.resetMessage.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Text(
                      cubit.resetMessage,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                // OTP / Activation code field
                CustomTextFormField(
                  labelStringText: 'Activate the code'.tr(),
                  controller: cubit.otpController,
                  hintText: '----',
                  outPadding: EdgeInsets.zero,
                  textInputType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Empty Field'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // New password
                CustomTextFormField(
                  labelStringText: 'Password'.tr(),
                  controller: cubit.passwordController,
                  hintText: 'Password'.tr(),
                  outPadding: EdgeInsets.zero,
                  password: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Empty Field'.tr();
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // Confirm password
                CustomTextFormField(
                  labelStringText: 'Confirm Password'.tr(),
                  controller: cubit.confirmPasswordController,
                  hintText: 'Re-enter Password'.tr(),
                  outPadding: EdgeInsets.zero,
                  password: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Empty Field'.tr();
                    }
                    if (value != cubit.passwordController.text) {
                      return 'passwords_not_match'.tr();
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                // Submit button
                BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                  buildWhen: (_, current) =>
                      current is VerifyLoading ||
                      current is VerifyError ||
                      current is VerifySuccess,
                  builder: (context, state) {
                    return CustomTextButton(
                      gradientColors: true,
                      stops: const [0.5, 1],
                      child: state is VerifyLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                  color: Colors.white, strokeWidth: 2),
                            )
                          : Text(
                              'Update Password'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                      onPress: () {
                        if (state is VerifyLoading) return;
                        if (!_formKey.currentState!.validate()) return;
                        cubit.resetPassword(context: context);
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
