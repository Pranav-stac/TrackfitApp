import 'package:flutter/material.dart';

class CurrentBio extends StatefulWidget {
  final VoidCallback onNext;
  final Function(int) onSave; // Add this line

  const CurrentBio({Key? key, required this.onNext, required this.onSave}) : super(key: key);

  @override
  State<CurrentBio> createState() => _CurrentBioState();
}

class _CurrentBioState extends State<CurrentBio> {
  int selectedHeight = 160; // Default selected height in CM

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
                      text: 'Current Height?',
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
          
              // Height Scroller
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '$selectedHeight',
                        style: const TextStyle(
                          fontFamily: 'Satoshi',
                          fontSize: 60,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'CM',
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
                height: 150, // Height of the height picker
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 60,
                  diameterRatio: 1.5,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      selectedHeight = index + 140; // Limit height from 140 to 200 CM
                    });
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final height = index + 140; // Adjust for minimum height
                      final isSelected = height == selectedHeight;
                      return Center(
                        child: Text(
                          '$height',
                          style: TextStyle(
                            fontFamily: 'Satoshi',
                            fontSize: 40,
                            color: isSelected ? Colors.white : Colors.grey,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                    childCount: 61, // Limit height to 140-200 CM
                  ),
                ),
              ),
              const SizedBox(height: 50),
             SizedBox(
                width: double.infinity, // Make the button full width
                child: TextButton(
                  onPressed: () {
                    widget.onSave(selectedHeight); // Save the selected age
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
