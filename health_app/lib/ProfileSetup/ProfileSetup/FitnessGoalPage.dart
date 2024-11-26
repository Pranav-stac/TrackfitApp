import 'package:flutter/material.dart';

class FitnessGoalPage extends StatefulWidget {
  final VoidCallback onNext;
  final Function(int) onSave; // Add this line

  const FitnessGoalPage({Key? key, required this.onNext, required this.onSave}) : super(key: key);

  @override
  _FitnessGoalPageState createState() => _FitnessGoalPageState();
}

class _FitnessGoalPageState extends State<FitnessGoalPage> {
  int? _selectedGoalIndex;

  void _selectGoal(int index) {
    setState(() {
      _selectedGoalIndex = index; // Set the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10), // Assuming a dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              RichText(
                text: const TextSpan(
                  text: 'What is your ',
                  style: TextStyle(
                    fontFamily: 'Satoshi',
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: 'Fitness Goal?',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00FFE0), // Highlighting color
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPlanContainer(0, 'Lose Weight', 'Burn fat and get lean.'),
                    _buildPlanContainer(1, 'Gain Muscle', 'Build mass & strength.'),
                    _buildPlanContainer(2, 'Get Fitter', 'Tone up & stay healthy.'),
                    _buildPlanContainer(3, 'Yoga & Wellness', 'Improve flexibility & reduce stress.'),
                  ],
                ),
              ),
             SizedBox(
                width: double.infinity, // Make the button full width
                child: TextButton(
                  onPressed: () {
                    widget.onSave(_selectedGoalIndex!); // Save the selected goal
                    widget.onNext();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(22, 99, 255, 237),
                    side: const BorderSide(color: Color(0xFF00FFE0)),
                    padding: const EdgeInsets.symmetric(vertical: 16.0), // Adjust padding for height
                  ),
                  child: Text(
                    'CONTINUE',
                    style: const TextStyle(
                      color: Color(0xFF00FFE0),
                      fontFamily: 'Satoshi',
                      fontSize: 16,
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

  Widget _buildPlanContainer(int index, String title, String subtext) {
    bool isSelected = _selectedGoalIndex == index;

    return GestureDetector(
      onTap: () => _selectGoal(index),
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF007BFF) : Color(0xFF0A3D37),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF00FFE0),
                fontSize: 18,
                fontFamily: 'Satoshi',
              ),
            ),
            Text(
              subtext,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Satoshi',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
