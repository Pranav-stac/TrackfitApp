import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/armode.dart';// Import the RemoteObject widget
import 'package:http/http.dart' as http;

class ExerciseDetailsPage extends StatelessWidget {
  final int day;
  final String category;

  const ExerciseDetailsPage({super.key, required this.day, required this.category});

  @override
  Widget build(BuildContext context) {
    List<String> yogaAsanas = [
      'halasana',
      'dandasana',
      'virabhadrasana ii',
      'vrischikasana',
      'lolasana',
      'vriksasana',
    ];

    List<String> exercises = day == 1 || day == 4
        ? yogaAsanas
        : category.split(', '); // Use API-generated exercises for other days

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Background color
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CupertinoNavigationBarBackButton(
          color: Colors.white, // iOS style back button
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Exercise List for Day $day',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF252525),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercises[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  'Reps: 10 | Sets: 3',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  print('Button pressed');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RemoteObject(
                                        modelPath: 'assets/${exercises[index]}.glb',
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD9D9D9),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'AR',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10), // Space between buttons
                              ElevatedButton(
                                onPressed: () async {
                                  final response = await http.post(
                                    Uri.parse('https://stable-simply-porpoise.ngrok-free.app/upload/'),
                                    body: {'key': 'value'}, // Replace with your actual data
                                  );
                                  
                                  // Add functionality for the new button here
                                  print('New Button pressed');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFD9D9D9),
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  'Check Posture',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontFamily: 'Satoshi',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Center(
                  child: Text(
                    'Click AR to check the correct form of the exercise',
                    style: const TextStyle(
                      color: Color(0xFFB0B0B0),
                      fontSize: 14,
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