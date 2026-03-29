import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/manager/register_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/widgets/all_technical_special_list_modal_bottom_sheet.dart';

class AddAdditionalItems extends StatefulWidget {
  final RegisterCubit registerCubit;

  const AddAdditionalItems({
    super.key,
    required this.registerCubit,
  });

  @override
  State<AddAdditionalItems> createState() => _AddAdditionalItemsState();
}

class _AddAdditionalItemsState extends State<AddAdditionalItems> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return SelectTechnicalSpecialListBottomSheet(
              registerCubit: widget.registerCubit,
            );
          },
        );
      },
      child: CustomTextFormField(
        labelStringText: 'Select your technical special'.tr(),
        controller: widget.registerCubit.nameController,
        hintText: 'technical special'.tr(),
        outPadding: EdgeInsets.zero,
        suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
        enable: false,
        borderColor: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}
