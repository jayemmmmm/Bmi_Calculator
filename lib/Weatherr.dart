import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // ✅ added for GPS
import 'BMI_Calculator.dart';
import 'notes.dart';
import 'weather_service.dart';
import 'settings.dart'; // ✅ import Settings screen

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService weatherService = WeatherService(); // ✅ removed "Tarlac,PH"
  Map<String, dynamic>? weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadWeather();
  }

  void loadWeather() async {
    try {
      // ✅ Request permission
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception("Location permission denied");
      }

      // ✅ Get current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // ✅ Fetch weather using coordinates
      final data = await weatherService.fetchWeatherByCoords(
        position.latitude,
        position.longitude,
      );

      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print("Error: $e");
    }
  }

  IconData getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "clear":
        return Icons.wb_sunny;
      case "clouds":
        return Icons.cloud;
      case "rain":
        return Icons.umbrella;
      case "drizzle":
        return Icons.grain;
      case "thunderstorm":
        return Icons.thunderstorm;
      case "snow":
        return Icons.ac_unit;
      case "mist":
      case "fog":
      case "haze":
        return Icons.cloud_queue;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C004F),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Weather Today",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 60),
            Text(
              "${weatherData!['name']}, ${weatherData!['sys']['country']}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            Icon(
              getWeatherIcon(weatherData!['weather'][0]['main']),
              color: Colors.lightBlueAccent,
              size: 80,
            ),
            const SizedBox(height: 10),
            Text(
              "${weatherData!['main']['temp'].round()}°",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "${weatherData!['weather'][0]['main']}",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 30),
            const Divider(
              color: Colors.white54,
              thickness: 1,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text("Feels Like",
                        style: TextStyle(color: Colors.white70)),
                    Text(
                      "${weatherData!['main']['feels_like'].round()}°",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Wind",
                        style: TextStyle(color: Colors.white70)),
                    Text(
                      "${weatherData!['wind']['speed']} m/s",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text("Humidity",
                        style: TextStyle(color: Colors.white70)),
                    Text(
                      "${weatherData!['main']['humidity']}%",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.purple.shade900,
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BMICalculatorPage()),
                );
              },
              child: Image.asset('assets/bmi.png', height: 40, width: 40),
            ),
            GestureDetector(
              onTap: () {
                // Already on Weather
              },
              child: Image.asset('assets/weather.png', height: 40, width: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const NotesPage()),
                );
              },
              child: Image.asset('assets/notes.png', height: 40, width: 40),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const SettingsPage()), // ✅ added
                );
                // Settings placeholder
              },
              child: Image.asset('assets/settings.png', height: 40, width: 40),
            ),
          ],
        ),
      ),
    );
  }
}
