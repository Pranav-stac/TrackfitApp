import 'package:flutter/material.dart';

class DietPref extends StatefulWidget {
  final VoidCallback onNext;
  final Function(int) onSave;

  const DietPref({Key? key, required this.onNext, required this.onSave}) : super(key: key);

  @override
  _DietPrefState createState() => _DietPrefState();
}

class _DietPrefState extends State<DietPref> {
  int? _selectedPreferenceIndex;

  void _selectPreference(int index) {
    setState(() {
      _selectedPreferenceIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  children: [
                    TextSpan(
                      text: 'Diet Preference?',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 38,
                        color: Color(0xFF00FFE0), 
                        fontWeight: FontWeight.bold// Highlighting "Diet Preference"
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildPreferenceContainer(0, 'Vegetarian'),
                    _buildPreferenceContainer(1, 'Non-Vegetarian'),
                    _buildPreferenceContainer(2, 'Vegan'),
                    _buildPreferenceContainer(3, 'Jain'),
                  ],
                ),
              ),
             SizedBox(
                width: double.infinity, // Make the button full width
                child: TextButton(
                  onPressed: () {
                    widget.onSave(_selectedPreferenceIndex!); // Save the selected preference
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

  Widget _buildPreferenceContainer(int index, String title) {
    bool isSelected = _selectedPreferenceIndex == index;

    return GestureDetector(
      onTap: () => _selectPreference(index),
      child: Container(
        width: double.infinity,
        height: 80,
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Color(0xFF0A0A0A), // Original background color
          borderRadius: BorderRadius.circular(24),
          border: isSelected ? Border.all(color: const Color(0xFF00FFE0), width: 2) : null, // Highlight border color when selected
        ),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white, // Text color
            fontSize: 30,
            fontFamily: 'Satoshi',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
