import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/utils.dart';
import 'package:matlop_provider/feature/auth/forgetPassword/manager/resetCubit/reset_password_cubit.dart';

class SetNewPasswordView extends StatelessWidget {
  const SetNewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Set New Password'.tr(), // English text for translation
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Create a new password. Make sure it is different from previous ones for security reasons.'.tr(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextFormField(
                labelStringText: 'Password'.tr(),
                controller: ResetPasswordCubit.of(context).passwordController,
                hintText: 'Password'.tr(),
                outPadding: EdgeInsets.zero,
                password: true,
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                labelStringText: 'Confirm Password'.tr(),
                controller: ResetPasswordCubit.of(context).confirmPasswordController,
                hintText: 'Re-enter Password'.tr(),
                outPadding: EdgeInsets.zero,
                password: true,
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextButton(
                gradientColors: true,
                stops: const [0.5, 1],
                child: Text(
                  'Update Password'.tr(), // English text for translation
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                onPress: () {
                  if (ResetPasswordCubit.of(context).passwordController.text.isNotEmpty &&
                      ResetPasswordCubit.of(context).passwordController.text == ResetPasswordCubit.of(context).confirmPasswordController.text) {
                    ResetPasswordCubit.of(context).resetPassword(context: context);
                  } else {
                    Utils.showToast(title: 'Passwords do not match', state: UtilState.warning);
                  }
                  // Action on password update
                },
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
