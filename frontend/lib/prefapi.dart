import 'dart:convert';

import 'package:frontend/prefmodel.dart';
import 'package:http/http.dart' as http;

class WeatherAppLocationApi {
  final String baseUrl = "http://192.168.1.7:8080/location";

  Future<PreferredLocationResponse> getPreferredLocation() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        return PreferredLocationResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Whoops failed to get weather details.");
      }
    } catch (e) {
      throw Exception("Whoops failed to get weather details.");
    }
  }

  void updatePreferredLocation(String location) async {
    try {
      await http.post(Uri.parse(baseUrl), body: location);
    } catch (e) {
      throw Exception("Whoops failed to get weather details.");
    }
  }
}
