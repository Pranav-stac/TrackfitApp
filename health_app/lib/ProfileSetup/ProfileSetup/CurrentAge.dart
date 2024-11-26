import 'package:flutter/material.dart';

class CurrentAge extends StatefulWidget {
  final VoidCallback onNext;
  final Function(int) onSave; // Add this line

  const CurrentAge({Key? key, required this.onNext, required this.onSave}) : super(key: key);

  @override
  State<CurrentAge> createState() => _CurrentAgeState();
}

class _CurrentAgeState extends State<CurrentAge> {
  int selectedAge = 25; // Default selected age

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 10, 10), // Assuming a dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                      text: 'Current Age?',
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00FFE0), // Color for 'Current Age?'
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        selectedAge.toString(),
                        style: const TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'YRS',
                        style: TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 40,
                          color: Color(0xFF00FFE0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 150, // Height of the picker
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 60,
                  diameterRatio: 1.5,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedAge = index + 1;
                    });
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final age = index + 1;
                      final isSelected = age == selectedAge;
                      return Center(
                        child: Text(
                          '$age',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 40,
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                    childCount: 100, // Limit age to 100
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const SizedBox(height: 50),
               SizedBox(
                width: double.infinity, // Make the button full width
                child: TextButton(
                  onPressed: () {
                    widget.onSave(selectedAge); // Save the selected age
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
}
