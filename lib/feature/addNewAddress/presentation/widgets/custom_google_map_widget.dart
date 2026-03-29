import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:matlop_provider/feature/addNewAddress/data/dataSource/map_service.dart';
import 'package:matlop_provider/feature/addNewAddress/data/models/predection_model.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/positioned_confirm_button.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/positioned_result_search.dart';
import 'package:matlop_provider/feature/addNewAddress/presentation/widgets/positioned_search_field.dart';

class CustomGoogleMapWidget extends StatefulWidget {
  const CustomGoogleMapWidget({super.key});

  @override
  State<CustomGoogleMapWidget> createState() => _CustomGoogleMapWidgetState();
}

class _CustomGoogleMapWidgetState extends State<CustomGoogleMapWidget> {
  late GoogleMapController googleMapController;
  String? _mapStyle;
  final Set<Marker> _markers = {};
  late LocationService locationService;
  late TextEditingController searchController;
  List<Prediction> predictions = [];

  String? selectedLat;
  String? selectedLon;

  @override
  void initState() {
    locationService = LocationService();
    searchController = TextEditingController();
    searchController.addListener(() {
      getPredictionList(inputData: searchController.text);
    });
    super.initState();
  }

  Future<void> getPredictionList({required String inputData}) async {
    predictions = await locationService.getPredictionData(inputData: inputData);
    setState(() {});
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          GoogleMap(
            style: _mapStyle,
            markers: _markers,
            onMapCreated: (controller) {
              googleMapController = controller;
              // getUserLocation();
            },
            onTap: (LatLng tappedPoint) {
              setState(() {
                selectedLat = tappedPoint.latitude.toString();
                selectedLon = tappedPoint.longitude.toString();
                // Add a marker at the tapped location
                _markers.add(
                  Marker(
                    markerId: const MarkerId('tappedLocation'),
                    position: tappedPoint,
                  ),
                );
              });
              log('Tapped Location: Latitude: $selectedLat, Longitude: $selectedLon');
            },
            initialCameraPosition: const CameraPosition(
              zoom: 14,
              target: LatLng(30.04422632972928, 31.247551793100282),
            ),
          ),
          PositionedSearchField(searchController: searchController),
          if (predictions.isNotEmpty) PositionedResultSearch(predictions: predictions),
          PositionedConfirmButton(selectedLat: selectedLat, selectedLon: selectedLon),
        ],
      ),
    );
  }

  // void getUserLocation() async {
  //   try {
  //     final locationData = await locationService.getCurrentLocation();
  //     final LatLng initialPosition = LatLng(locationData.latitude!, locationData.longitude!);
  //     googleMapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(target: initialPosition, zoom: 16),
  //       ),
  //     );
  //     _markers.add(
  //       Marker(markerId: const MarkerId('1'), position: initialPosition),
  //     );
  //     setState(() {});
  //   } catch (e) {
  //     log('getCurrentLocation $e');
  //   }
  // }
}
