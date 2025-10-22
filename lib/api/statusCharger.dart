import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class BatteryService with ChangeNotifier{
  String _batteryStatus = 'Loading...';
  double _chargerPercentage = 0.0;
  bool _isCharging = false;


  String get batteryStatus => _batteryStatus;
  double get chargerPercentage => _chargerPercentage;
  bool get isCharging => _isCharging;

  Future<void> getChargerStatus(String vehicleId, String accessToken) async {
    final url = Uri.parse('https://api.smartcar.com/v2.0/vehicles/$vehicleId/charge');

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
        _batteryStatus = '${data['battery_capacity']} kWh';
        _chargerPercentage = data['state_of_charge'] ?? 0.0;
        _isCharging = data['charging'];

        notifyListeners();
      } else {
        _batteryStatus = 'Error: ${response.statusCode}';
        _chargerPercentage = 0.0;
        _isCharging = false;

        notifyListeners();
      }
    } catch (e) {
      _batteryStatus = 'Error de conexión';
      _chargerPercentage = 0.0;
      _isCharging = false;
      notifyListeners();
    }
  }

  
}