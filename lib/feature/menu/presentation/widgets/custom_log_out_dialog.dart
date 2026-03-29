import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';

class CustomLogoutDialog extends StatelessWidget {
  const CustomLogoutDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Do you want to logout?'.tr(), // Added .tr() here
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextButton(
                  child: Text(
                    'No'.tr(), // Added .tr() here
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomTextButton(
                  backgroundColor: Colors.white,
                  borderColor: AppColors.primaryColor,
                  child: Text(
                    'Yes, Logout'.tr(), // Added .tr() here
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryColor),
                  ),
                  onPress: () {
                    userCacheValue = null;
                    userCache?.put(userCacheKey, '{}');
                    Constants.token = '';
                    context.navigateToPage(BlocProvider(create: (_) => LoginCubit(), child: const LoginView()));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
