import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/loading_widget.dart';
import 'package:matlop_provider/core/network/dio_helper.dart';
import 'package:matlop_provider/core/network/end_points.dart';
import 'package:matlop_provider/core/network/local/cache.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/core/utils/constants.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/auth/login/presentation/login_view.dart';
import 'package:matlop_provider/feature/auth/login/presentation/manager/cubit/login_cubit.dart';

class CustomLogoutDialog extends StatelessWidget {
  const CustomLogoutDialog({super.key});

  Future<void> _performLogout(BuildContext context) async {
    // Show loading FIRST — context is still valid because the bottom sheet is alive
    animationDialogLoading(context);

    try {
      await DioHelper.postData(
        endPoint: EndPoints.logout,
        data: {'token': Constants.fcmToken},
      );
    } catch (_) {
      // Ignore errors — always log out locally
    } finally {
      // Clear local session data — including profileCacheValue so old
      // account image/name never leaks into the next login session.
      userCacheValue = null;
      profileCacheValue = null;
      userCache?.put(userCacheKey, '{}');
      userCache?.put(profileCacheKey, '{}');
      Constants.token = '';
      Constants.fcmToken = '';

      if (context.mounted) {
        // pushAndRemoveUntil removes ALL routes (loading dialog + bottom sheet)
        // and pushes LoginView cleanly
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => LoginCubit(),
              child: const LoginView(),
            ),
          ),
          (route) => false,
        );
      }
    }
  }

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
            'Do you want to logout?'.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.primaryColor,
                ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomTextButton(
                  child: Text(
                    'No'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                  onPress: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CustomTextButton(
                  backgroundColor: Colors.white,
                  borderColor: AppColors.primaryColor,
                  child: Text(
                    'Yes, Logout'.tr(),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: AppColors.primaryColor),
                  ),
                  onPress: () => _performLogout(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
