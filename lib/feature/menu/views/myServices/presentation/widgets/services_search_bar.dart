import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class ServicesSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const ServicesSearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      hintText: 'Search Services...'.tr(),
      onChange: onChanged,
      outPadding: EdgeInsets.zero,
      borderRadius: 12,
      validator: (_) => null,
      prefixIcon: const Icon(
        Icons.search_rounded,
        color: AppColors.subTextColor,
        size: 20,
      ),
    );
  }
}
