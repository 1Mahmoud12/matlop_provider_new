import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class DeleteAccountDialog extends StatelessWidget {
  const DeleteAccountDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Access the DeleteAccountCubit using BlocProvider
    //final deleteAccountCubit = BlocProvider.of<DeleteAccountCubit>(context);

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
            'Do you want Delete your account?'.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppColors.red,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Please note that once the account deletion is confirmed, you will not be able to recover it again.'.tr(),
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.grey.withOpacity(0.8),
                ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextButton(
                  borderRadius: 15,
                  child: Text(
                    "I don't want".tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  ),
                  onPress: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomTextButton(
                  borderRadius: 15,
                  backgroundColor: Colors.white,
                  borderColor: AppColors.primaryColor,
                  child: Text(
                    'Yes, Delete'.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primaryColor),
                  ),
                  onPress: () {
                   // deleteAccountCubit.deleteAccount(context);
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
