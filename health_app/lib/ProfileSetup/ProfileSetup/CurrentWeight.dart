import 'package:flutter/material.dart';

class CurrentWeight extends StatefulWidget {
  final VoidCallback onNext;
  final Function(int) onSave; // Add this line

  const CurrentWeight({Key? key, required this.onNext, required this.onSave}) : super(key: key);

  @override
  State<CurrentWeight> createState() => _CurrentWeightState();
}

class _CurrentWeightState extends State<CurrentWeight> {
  int selectedWeight = 60; // Default selected weight in KGS

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10), // Dark background
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
                      text: 'Current Weight?',
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
              const SizedBox(height: 50),

              // Weight Scroller
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$selectedWeight',
                        style: const TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'KGS',
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
                height: 150, // Height of the weight picker
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 60,
                  diameterRatio: 1.5,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedWeight = index + 30; // Limit weight from 30 to 130 KGS
                    });
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final weight = index + 30; // Adjust for minimum weight
                      final isSelected = weight == selectedWeight;
                      return Center(
                        child: Text(
                          '$weight',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 40,
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                    childCount: 101, // Limit weight to 30-130 KGS
                  ),
                ),
              ),
              const SizedBox(height: 50),
             SizedBox(
                width: double.infinity, // Make the button full width
                child: TextButton(
                  onPressed: () {
                    widget.onSave(selectedWeight); // Save the selected age
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
