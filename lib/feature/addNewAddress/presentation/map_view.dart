import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/component/custom_app_bar.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/custom_google_map_widget.dart';

class AddAddressMapView extends StatelessWidget {
  const AddAddressMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Map'.tr()),
      body: const CustomGoogleMapWidget(),
    );
  }
}
