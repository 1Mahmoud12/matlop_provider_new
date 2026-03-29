import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matlop_provider/core/component/buttons/arrow_back_button.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/constants_enum.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/manager/register_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/sign_up_view.dart';
class UserTypeView extends StatelessWidget {
  const UserTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: '',),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [


              Image.asset(
                AppImages.logo,
                fit: BoxFit.cover,
                height: 100,
                width: 200,
              ),
              Text(
                'Welcome to Matlop'.tr(),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13.sp),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'هذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 13.sp, color: AppColors.textColor),
                textAlign: TextAlign.center,
              ),
              AspectRatio(aspectRatio: 1.5, child: Image.asset(AppImages.somethingwentwrong)),
              const SizedBox(
                height: 40,
              ),
              CustomTextButton(
                  borderRadius: 16,
                  child: Text(
                    'Technical Employee'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.white),
                  ),
                  onPress: () {
                    context.navigateToPage(BlocProvider(create: (context) => RegisterCubit(TechType.technical),child: const SignUpView()));
                  }),
              const SizedBox(
                height: 20,
              ),
              CustomTextButton(
                  backgroundColor: Colors.white,
                  borderColor: AppColors.primaryColor,
                  borderRadius: 16,
                  child: Text(
                    'Cooperative Technician'.tr(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.primaryColor),
                  ),
                  onPress: () {

                    context.navigateToPage(BlocProvider(create: (context) => RegisterCubit(TechType.cooperate),child: const SignUpView()));

                  })
            ],
          ),
        ),
      ),
    );
  }
}
