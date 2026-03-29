import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';

class ModifyPasswordBottomSheet extends StatelessWidget {
  const ModifyPasswordBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Modify Password'.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Add old password then the new password the confirm it'.tr(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.grey.withOpacity(0.8)),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              outPadding: EdgeInsets.zero,
              controller: TextEditingController(),
              hintText: 'Old Password'.tr(),
              password: true,
              labelStringText: 'Old Password'.tr(),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              outPadding: EdgeInsets.zero,
              controller: TextEditingController(),
              hintText: 'New Password'.tr(),
              password: true,
              labelStringText: 'New Password'.tr(),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextFormField(
              outPadding: EdgeInsets.zero,
              controller: TextEditingController(),
              hintText: 'Confirm Password'.tr(),
              password: true,
              labelStringText: 'Confirm Password'.tr(),
            ),
            const SizedBox(
              height: 30,
            ),
            CustomTextButton(
                borderRadius: 16,
                onPress: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Confirm'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
