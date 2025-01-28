import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class LocationService {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition(
      // ignore: deprecated_member_use
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> getAddressFromLatLng() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '''${place.street}, ${place.subLocality}, ${place.locality}, ${place.administrativeArea}''';
      } else {
        return "No address found for the current location.";
      }
    } catch (e) {
      return "Error: $e";
    }
  }

  final String apiKey = "AIzaSyAaPwZtN4MELZaWBqSTDbylo_OtPBZ2GIs";

  Future<List<dynamic>> fetchPlaceSuggestions(
      String input, String sessionToken) async {
    try {
      String baseUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json";
      String request =
          "$baseUrl?input=$input&key=$apiKey&sessiontoken=$sessionToken";

      var response = await http.get(Uri.parse(request));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (kDebugMode) {
          print(data);
        }
        return data['predictions'] ?? [];
      } else {
        throw Exception('Failed to load place suggestions');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching place suggestions: ${e.toString()}");
      }
      return [];
    }
  }
}
