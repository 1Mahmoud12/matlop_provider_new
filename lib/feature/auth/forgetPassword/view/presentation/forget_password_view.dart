import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/auth/forgetPassword/manager/resetCubit/reset_password_cubit.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final formKey = GlobalKey<FormState>();
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
                'Forgot Password'.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Please enter your phone number to reset your password'.tr(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                key: formKey,
                child: CustomTextFormField(
                  labelStringText: 'Phone Number'.tr(),
                  controller: ResetPasswordCubit.of(context).phoneController,
                  hintText: '05xxxxxxxx',
                  textInputType: TextInputType.number,
                  outPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextButton(
                gradientColors: true,
                stops: const [0.5, 1],
                child: Text(
                  'Reset Password'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                onPress: () {
                  if (formKey.currentState!.validate()) ResetPasswordCubit.of(context).verifyPhoneNumber(context: context);
                  //context.navigateToPage(const OtpView());
                },
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
