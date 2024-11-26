import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CalorieFinder extends StatefulWidget {
  const CalorieFinder({super.key});

  @override
  State<CalorieFinder> createState() => _CalorieFinderState();
}

class _CalorieFinderState extends State<CalorieFinder> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _portionSizeController = TextEditingController();
  final TextEditingController _dishNameController = TextEditingController();
  String _nutritionInfo = ''; // Add this line to store nutrition info

  Future<void> _fetchNutritionData(String food) async {
    final apiUrl = 'https://api.calorieninjas.com/v1/nutrition?query=$food';
    print("Querying API with: $food"); // Debugging line
    final apiKey = 'BNvj/wvjC0oIEznDEJP66Q==8yu0gvZEqoGkCMBQ'; // Replace with your actual API key

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'X-Api-Key': apiKey},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['items'].isNotEmpty) {
          double totalCalories = 0.0;
          String itemsText = '';

          for (var item in data['items']) {
            totalCalories += item['calories'];
            itemsText += '''
${item['name']}:
  Calories: ${item['calories']} cal
  Sugar: ${item['sugar_g']} g
  Fiber: ${item['fiber_g']} g
  Serving Size: ${item['serving_size_g']} g
  Sodium: ${item['sodium_mg']} mg
  Potassium: ${item['potassium_mg']} mg
  Saturated Fat: ${item['fat_saturated_g']} g
  Total Fat: ${item['fat_total_g']} g
  Cholesterol: ${item['cholesterol_mg']} mg
  Protein: ${item['protein_g']} g
  Carbohydrates: ${item['carbohydrates_total_g']} g
''';
          }

          setState(() {
            _nutritionInfo = 'Total Calories: $totalCalories\n$itemsText';
          });
        } else {
          setState(() {
            _nutritionInfo = 'No nutrition data found for $food.';
          });
        }
      } else {
        setState(() {
          _nutritionInfo = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _nutritionInfo = 'Failed to fetch data: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Calorie Finder',
        style: TextStyle(color: Colors.white,
        fontFamily: 'Satoshi'
        ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Portion Size Input
                const SizedBox(height: 10),
                const SizedBox(height: 20),
                
                // Dish Name Input
                const Text(
                  'Name of Dish',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _dishNameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter the name of the dish',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E), // Field background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the name of the dish';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                
                // Send Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _fetchNutritionData(_dishNameController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FFE0), // Button color
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Send',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black, // Text color
                        fontFamily: 'Satoshi',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Display Nutrition Info
                Text(
                  _nutritionInfo,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}