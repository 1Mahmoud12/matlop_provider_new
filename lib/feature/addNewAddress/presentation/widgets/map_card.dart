import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:matlop_provider/core/utils/app_images.dart';
import 'package:matlop_provider/core/utils/navigate.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/map_view.dart';

class MapCard extends StatefulWidget {
  const MapCard({super.key});

  @override
  MapCardState createState() => MapCardState();
}

class MapCardState extends State<MapCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //  context.navigateToPage(const AddAddressMapView());
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height * 0.2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(context.locale.languageCode == 'ar' ? AppImages.googleMapAr : AppImages.googleMap),
        ),
      ),
    );
  }
}
