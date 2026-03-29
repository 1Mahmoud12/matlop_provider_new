import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class SendMessageTextField extends StatelessWidget {
  const SendMessageTextField({super.key, required this.controller, this.onTapAttachment});
  final TextEditingController controller;
  final void Function()? onTapAttachment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomTextFormField(
        outPadding: EdgeInsets.zero,
        height: .08,
        controller: controller,
        onChange: (value) {},
        hintText: 'Write your message...'.tr(),
        focusedBorderColor: AppColors.transparent,
        enabledBorder: AppColors.transparent,
        // prefixIcon: Padding(
        //   padding: EdgeInsets.only(
        //     left: context.locale.languageCode == 'ar' ? 0 : 10,
        //     right: context.locale.languageCode == 'ar' ? 10 : 0,
        //   ),
        //   child: Row(
        //     mainAxisSize: MainAxisSize.min,
        //     children: [
        //       GestureDetector(
        //         onTap: onTapAttachment,
        //         child: SvgPicture.asset(
        //           AppIcons.attachment,
        //           width: context.screenWidth * .07,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
