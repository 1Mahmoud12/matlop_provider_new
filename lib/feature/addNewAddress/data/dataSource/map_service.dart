import 'dart:convert';
import 'dart:developer';

import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:matlop_provider/feature/addNewAddress/data/models/predection_model.dart';

class LocationService {
  Location location = Location();

  Future<void> checkAndRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw Exception();
      }
    }
  }

  Future<void> checkAndRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw Exception();
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw Exception();
      }
    }
  }

  void getRealTimeLocationData(void Function(LocationData)? onData) {
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getCurrentLocation() async {
    checkAndRequestLocationService();
    checkAndRequestLocationPermission();
    return location.getLocation();
  }

  final String apiKey = 'AIzaSyBGY3DsFpEBvRGn20YgIkQirU1EYkoiKSY';
  final String predictionUrl = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';

  Future<List<Prediction>> getPredictionData({required String inputData}) async {
    final List<Prediction> predictionList = [];

    try {
      // Constructing the URL with the input and API key
      final uri = Uri.parse('$predictionUrl?input=$inputData&key=$apiKey');

      // Sending the GET request
      final response = await http.get(uri);

      // Check if the response is successful (status code 200)
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Checking if 'predictions' is a valid list
        if (jsonData['predictions'] != null) {
          final predictions = jsonData['predictions'] as List;

          // Parsing each prediction from JSON to the model
          for (final element in predictions) {
            predictionList.add(Prediction.fromJson(element));
          }
        }
      } else {
        // Logging the error if the status code is not 200
        log('Failed to load predictions: ${response.statusCode}');
      }
    } catch (e) {
      // Catching and logging any exceptions during the request
      log('Error in getPredictionData: $e');
    }

    return predictionList;
  }
}
