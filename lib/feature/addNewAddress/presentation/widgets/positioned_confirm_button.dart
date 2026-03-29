import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/buttons/custom_text_button.dart';
import 'package:matlop_provider/core/themes/colors.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/manager/addNewAddress/cubit/add_new_address_cubit.dart';

class PositionedConfirmButton extends StatelessWidget {
  const PositionedConfirmButton({
    super.key,
    required this.selectedLat,
    required this.selectedLon,
  });

  final String? selectedLat;
  final String? selectedLon;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 10,
      left: 16,
      right: 16,
      child: CustomTextButton(
        borderRadius: 12,
        backgroundColor: selectedLat != null && selectedLon != null ? AppColors.primaryColor : Colors.grey.withOpacity(0.8),
        child: Text(
          'Confirm'.tr(),
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
        ),
        onPress: () {
          if (selectedLat != null && selectedLon != null) {
            AddNewAddressCubit.of(context).lat = selectedLat ?? '';
            AddNewAddressCubit.of(context).lon = selectedLon ?? '';
            log('Confirmed Location: Latitude: $selectedLat, Longitude: $selectedLon');
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
