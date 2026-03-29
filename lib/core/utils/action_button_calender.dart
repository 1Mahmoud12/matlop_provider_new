import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class ActionButtons extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ActionButtons({super.key, required this.onConfirm, required this.onCancel});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextButton(
            borderRadius: 16,
            onPress: onConfirm,
            child: Text(
              'Confirm'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: CustomTextButton(
            backgroundColor: Colors.white,
            borderColor: AppColors.primaryColor,
            borderRadius: 16,
            onPress: onCancel,
            child: Text(
              'Cancel'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
