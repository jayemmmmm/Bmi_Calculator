import 'package:flutter/material.dart';
import 'BMI_Calculator.dart';
import 'weatherr.dart';
import 'settings.dart'; // ✅ import Settings screen

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  // ✅ Global static notes list (hindi nare-reset kahit navigate)
  static List<Map<String, String>> notes = [
    {"title": "", "height": "", "weight": "", "date": ""}

  ];

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  void editNoteDialog(int index) {
    final titleController =
    TextEditingController(text: NotesPage.notes[index]["title"]);
    final heightController =
    TextEditingController(text: NotesPage.notes[index]["height"]);
    final weightController =
    TextEditingController(text: NotesPage.notes[index]["weight"]);
    final dateController =
    TextEditingController(text: NotesPage.notes[index]["date"]);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Edit Note"),
          content: SizedBox( // 🔹 pinalaki yung dialog
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 06,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: "Title/Name"),
                  ),
                  TextField(
                    controller: heightController,
                    decoration: const InputDecoration(labelText: "Height"),
                  ),
                  TextField(
                    controller: weightController,
                    decoration: const InputDecoration(labelText: "Weight"),
                  ),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(labelText: "Date"),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  NotesPage.notes[index] = {
                    "title": titleController.text,
                    "height": heightController.text,
                    "weight": weightController.text,
                    "date": dateController.text,
                  };
                });
                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF210033),
      appBar: AppBar(
        backgroundColor: const Color(0xFF210033),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notes",
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: NotesPage.notes.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final note = NotesPage.notes[index];
            return GestureDetector(
              onTap: () => editNoteDialog(index),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            note["title"] ?? "",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              NotesPage.notes.removeAt(index); // ✅ delete
                            });
                          },
                          child: const Icon(Icons.delete, size: 24),
                        ),
                      ],
                    ),
                    if ((note["height"] ?? "").isNotEmpty)
                      Text("Height: ${note["height"]}"),
                    if ((note["weight"] ?? "").isNotEmpty)
                      Text("Weight: ${note["weight"]}"),
                    if ((note["date"] ?? "").isNotEmpty)
                      Text("Date: ${note["date"]}"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        shape: const CircleBorder(
            side: BorderSide(width: 2, color: Colors.black)),
        onPressed: () {
          setState(() {
            NotesPage.notes
                .add({"title": "", "height": "", "weight": "", "date": ""});
          });
        },
        child: const Icon(Icons.add, color: Colors.black, size: 36),
      ),
      // ✅ Updated bottom navigation bar with solid background
      bottomNavigationBar: Container(
        height: 70,
        color: const Color(0xFF210033), // 🔹 solid background
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BMICalculatorPage()),
                );
              },
              child: Image.asset('assets/bmi.png', height: 50, width: 50),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => WeatherScreen()),
                );
              },
              child: Image.asset('assets/weather.png', height: 50, width: 50),
            ),
            GestureDetector(
              onTap: () {
                // Already on Notes
              },
              child: Image.asset('assets/notes.png', height: 50, width: 50),
            ),
            GestureDetector(
              onTap: () { Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const SettingsPage()), // ✅ added
              );
                // Settings placeholder
              },
              child: Image.asset('assets/settings.png', height: 50, width: 50),
            ),
          ],
        ),
      ),
    );
  }
}
