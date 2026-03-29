import 'package:google_maps_flutter/google_maps_flutter.dart';

class Place {
  final String id;
  final String name;
  final LatLng latLong;

  Place({
    required this.id,
    required this.name,
    required this.latLong,
  });
}

final List<Place> places = [
  Place(
    id: '1',
    name: 'Statue of Liberty',
    latLong: const LatLng(40.689247, -74.044502),
  ),
  Place(
    id: '2',
    name: 'Eiffel Tower',
    latLong: const LatLng(48.858844, 2.294351),
  ),
  Place(
    id: '3',
    name: 'Pyramids of Giza',
    latLong: const LatLng(29.979235, 31.134202),
  ),
];
