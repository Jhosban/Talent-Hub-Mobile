import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarService with ChangeNotifier {
  String _batteryCapacity = 'Loading...';
  String get batteryCapacity => _batteryCapacity;

  Future<void> getBatteryCapacity() async {
    const String vehicleId = 'abc123'; // Reemplázalo con el ID real del vehículo
    const String accessToken = 'tu_access_token'; // Token de autenticación

    final url = Uri.parse('https://api.smartcar.com/v2.0/vehicles/$vehicleId/battery/nominal_capacity');

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $accessToken",
          "Content-Type": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _batteryCapacity = '${data['capacity']} kWh';
      } else {
        _batteryCapacity = 'Error de conexión';
      }
    } catch (e) {
      _batteryCapacity = 'Error de conexión';
    }

    notifyListeners();
  }
}
