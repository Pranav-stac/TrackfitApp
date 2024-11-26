import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/ExerciseDetail.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Import the Gemini API package

class ExercisePage extends StatefulWidget {
  const ExercisePage({super.key});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  int selectedDay = 1; // Variable to track selected day
  List<String> exerciseCategories = List.filled(7, ''); // Placeholder for exercise categories

  @override
  void initState() {
    super.initState();
    _generateWorkoutPlan(); // Generate workout plan on initialization
  }

  Future<void> _generateWorkoutPlan() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "YOUR_API_KEY", // Replace with your actual API key
    );

    final days = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];
    final Map<String, String> workoutPlan = {};

    for (var day in days) {
      String prompt;
      if (day == 'Day 1' || day == 'Day 4') {
        prompt = 'Generate a Yoga workout plan for $day.';
      } else {
        prompt = 'Generate a workout plan for $day with categories: Chest & Shoulders, Glutes, Quads, and Hamstrings, Back and Arms. Include one exercise as Squat for Glutes, Quads, and Hamstrings.';
      }

      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      workoutPlan[day] = response.text ?? '';
    }

    setState(() {
      exerciseCategories = workoutPlan.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Background color
      appBar: AppBar(
        backgroundColor: Color(0xFF0A0A0A),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Run it off!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Satoshi',
                  ),
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Your Current Plan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDay = index + 1;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseDetailsPage(
                              day: index + 1,
                              category: exerciseCategories[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFF252525),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selectedDay == index + 1
                                ? Colors.blue
                                : Colors.transparent,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Day ${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Satoshi',
                              ),
                            ),
                            Text(
                              exerciseCategories[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _generateWorkoutPlan,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    alignment: Alignment.center,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'AI Generated Workout Plan',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                      fontFamily: 'Satoshi',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}