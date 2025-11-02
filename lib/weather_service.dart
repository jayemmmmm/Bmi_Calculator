import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = "b1a983b477fc8973339630d2b2b96d0d"; // ✅ your API key
  final String baseUrl = "https://api.openweathermap.org/data/2.5/weather";

  Future<Map<String, dynamic>> fetchWeatherByCoords(double lat, double lon) async {
    final url = Uri.parse(
      "$baseUrl?lat=$lat&lon=$lon&appid=$apiKey&units=metric",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Failed to load weather data");
    }
  }
}
