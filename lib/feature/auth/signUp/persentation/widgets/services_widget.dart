import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_text_form_field.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/manager/register_cubit.dart';
import 'package:matlop_provider/feature/auth/signUp/persentation/widgets/all_services_modal_bottom_sheet.dart';

class ServicesWidget extends StatefulWidget {
  final RegisterCubit registerCubit;

  const ServicesWidget({
    super.key,
    required this.registerCubit,
  });

  @override
  State<ServicesWidget> createState() => _ServicesWidgetState();
}

class _ServicesWidgetState extends State<ServicesWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) {
            return SelectServicesBottomSheet(
              registerCubit: widget.registerCubit,
            );
          },
        );
      },
      child: CustomTextFormField(
        labelStringText: 'Select services'.tr(),
        controller: widget.registerCubit.servicesController,
        hintText: 'Services'.tr(),
        outPadding: EdgeInsets.zero,
        suffixIcon: const Icon(Icons.keyboard_arrow_down_sharp),
        enable: false,
        borderColor: Colors.grey.withOpacity(0.2),
      ),
    );
  }
}
