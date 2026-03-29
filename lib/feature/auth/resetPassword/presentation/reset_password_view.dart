import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/auth/resetPassword/set_new_password_view.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

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
                'Reset Password'.tr(), // Translated text
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your password has been reset successfully. Click "Confirm" to set a new password.'.tr(), // Translated text
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
              ),
              const SizedBox(
                height: 60,
              ),
              CustomTextButton(
                gradientColors: true,
                stops: const [0.5, 1],
                child: Text(
                  'Confirm'.tr(), // Translated text
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                onPress: () {
                  context.navigateToPage(const SetNewPasswordView());
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
