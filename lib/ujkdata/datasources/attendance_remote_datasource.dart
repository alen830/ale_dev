import 'dart:convert';

import 'package:ale_dev/tugas11/services/preference_handler.dart';

import 'package:http/http.dart' as http;

import '../../core/utils/preference_helper.dart';

class AttendanceRemoteDatasource {
  final String baseUrl;
  AttendanceRemoteDatasource({required this.baseUrl});

  Future<bool> checkIn(double latitude, double longitude) async {
    return _sendAttendance('/absen-check-in', latitude, longitude);
  }

  Future<bool> checkOut(double latitude, double longitude) async {
    return _sendAttendance('/absen-check-out', latitude, longitude);
  }

  Future<bool> _sendAttendance(String endpoint, double lat, double lng) async {
    final token = await PreferenceHandler.getToken();
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'latitude': lat, 'longitude': lng}),
    );

    return response.statusCode == 200;
  }
}
