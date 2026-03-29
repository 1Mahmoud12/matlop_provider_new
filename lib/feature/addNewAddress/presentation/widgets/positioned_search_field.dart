import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/core/themes/colors.dart';

class PositionedSearchField extends StatelessWidget {
  const PositionedSearchField({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: MediaQuery.sizeOf(context).width,
        height: 50,
        child: CustomTextFormField(
          labelStringText: 'Search'.tr(),
          controller: searchController,
          hintText: 'Search'.tr(),
          hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textColor),
          outPadding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
