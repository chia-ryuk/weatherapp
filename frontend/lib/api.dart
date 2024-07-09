import 'dart:convert';

import 'package:frontend/constants.dart';
import 'package:frontend/weathermodel.dart';
import 'package:http/http.dart' as http;

/// The [WeatherAppApi] class provides methods to interact with the weather API.
/// It includes methods to fetch current weather data for a specified location.

class WeatherAppApi {
  /// The base URL for the weather API.
  final String baseUrl = "http://api.weatherapi.com/v1/current.json";

  /// Fetches the current weather data for the specified [location].
  /// This method constructs the API URL using the [baseUrl], [apiKey], and the provided [location]. It then sends an HTTP GET request to the API.
  /// If the request is successful (status code 200), it parses the JSON response and returns a [WeatherResponse] object. If the request fails, it throws an exception with an error message.
  /// Throws:
  /// - [Exception] if the request fails or if the API returns a non-200 status code.

  Future<WeatherResponse> getCurrentWeather(String location) async {
    String apiUrl = "$baseUrl?key=$apiKey&q=$location";
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        return WeatherResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Whoops failed to get weather details.");
      }
    } catch (e) {
      throw Exception("Whoops failed to get weather details.");
    }
  }
}
