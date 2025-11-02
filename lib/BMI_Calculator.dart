  import 'package:flutter/material.dart';
  import 'weatherr.dart'; // import Weather screen
  import 'notes.dart';   // import Notes screen
  import 'settings.dart'; // ✅ import Settings screen

  class BMICalculatorPage extends StatefulWidget {
    const BMICalculatorPage({super.key});

    @override
    State<BMICalculatorPage> createState() => _BMICalculatorPageState();
  }

  class _BMICalculatorPageState extends State<BMICalculatorPage> {
    final TextEditingController heightController = TextEditingController();
    final TextEditingController weightController = TextEditingController();
    double? bmi;

    void calculateBMI() {
      final double? height = double.tryParse(heightController.text);
      final double? weight = double.tryParse(weightController.text);

      if (height != null && weight != null && height > 0) {
        setState(() {
          bmi = weight / ((height / 100) * (height / 100));
        });
      }
    }

    String getBMICategory() {
      if (bmi == null) return "";
      if (bmi! < 18.5) return "Underweight";
      if (bmi! < 25) return "Healthy";
      if (bmi! < 30) return "Overweight";
      return "Obesity";
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: const Color(0xFF1E002A),
        body: SafeArea(
          child: Column(
            children: [
              // 🔹 Header
              Container(
                padding: const EdgeInsets.all(16),
                color: Colors.purple.shade900,
                width: double.infinity,
                child: const Text(
                  "BMI CALCULATOR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // 🔹 Input fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: heightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        labelText: "height (cm)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: weightController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white70,
                        labelText: "weight (kg)",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 🔹 Calculate button
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                  foregroundColor: Colors.black,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text("Calculate"),
              ),

              const Divider(color: Colors.white, height: 40),

              // 🔹 BMI Result
              Container(
                color: Colors.purple.shade900,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    const Text(
                      "YOUR BMI IS",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      bmi == null ? "--" : bmi!.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      getBMICategory(),
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 🔹 BMI Categories
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: const [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("BMI Category",
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                        Text("Range",
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Underweight", style: TextStyle(color: Colors.white)),
                        Text("Below 18.5", style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Healthy", style: TextStyle(color: Colors.white)),
                        Text("18.5 – 24.9",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Overweight", style: TextStyle(color: Colors.white)),
                        Text("25.0 – 29.9",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Obesity", style: TextStyle(color: Colors.white)),
                        Text("30.0 or above",
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // 🔹 Bottom navigation images
              Container(
                color: Colors.purple.shade900,
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Already on BMI
                      },
                      child: Image.asset('assets/bmi.png', height: 40, width: 40),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeatherScreen()),
                        );
                      },
                      child:
                      Image.asset('assets/weather.png', height: 40, width: 40),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NotesPage()),
                        );
                      },
                      child:
                      Image.asset('assets/notes.png', height: 40, width: 40),
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
                      child: Image.asset('assets/settings.png',
                          height: 40, width: 40),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
