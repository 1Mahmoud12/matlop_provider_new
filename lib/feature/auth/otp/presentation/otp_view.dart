import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/widgets/account_action_text.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpView extends StatefulWidget {
  final void Function(String) onCompleted;
  final void Function()? resend;

  const OtpView({super.key, required this.onCompleted, this.resend});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  String newOtp = '';

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
                'Please enter the sent code'.tr(), // English text to be translated
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20.sp),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'A code has been sent to your phone number. Please enter it'.tr(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textColor),
              ),
              const SizedBox(
                height: 30,
              ),
              // OTP Input Field
              PinInputFormField(
                length: 4,
                keyboardType: TextInputType.number,
                pinBuilder: (context, cells) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: cells.map((cell) {
                      final borderColor = cell.isFocused
                          ? AppColors.primaryColor
                          : cell.isFilled
                              ? AppColors.primaryColor
                              : AppColors.primaryColor.withOpacity(.5);

                      return Container(
                        width: 55.w,
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: borderColor),
                        ),
                        child: Text(
                          cell.character ?? '',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: 20.sp,
                                color: AppColors.primaryColor,
                              ),
                        ),
                      );
                    }).toList(),
                  );
                },
                onCompleted: (value) {
                  widget.onCompleted(value);
                },
                onChanged: (value) {
                  newOtp = value;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              CustomTextButton(
                gradientColors: true,
                stops: const [0.5, 1],
                child: Text(
                  'Activate the code'.tr(), // English text to be translated
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white,
                      ),
                ),
                onPress: () {
                  widget.onCompleted(newOtp);
                  // context.navigateToPage(const ResetPasswordView());
                },
              ),
              const SizedBox(
                height: 10,
              ),
              AccountActionText(
                text1: "Didn't receive the code?".tr(), // English text to be translated
                text2: 'Resend'.tr(), // English text to be translated
                onTap: () {
                  widget.resend?.call();
                  // context.navigateToPage(BlocProvider(create: (context) => RegisterCubit(),child: const SignUpView()));
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
