import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart'; // Import the AI package
import 'package:health_app/Diet.dart'; // Import DietPlanPage

class NewDietPlan extends StatefulWidget {
  const NewDietPlan({super.key});

  @override
  State<NewDietPlan> createState() => _NewDietPlanState();
}

class _NewDietPlanState extends State<NewDietPlan> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _nutAllergiesController = TextEditingController();

  Future<Map<String, Map<String, dynamic>>> _generateDietPlan() async {
    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: "AIzaSyBtg_JyBr0sZQ4l_dVyvkl0KXZAfhFFr5E",
    );

    final days = ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5', 'Day 6', 'Day 7'];
    final Map<String, Map<String, dynamic>> weeklyDietPlan = {};

    for (var day in days) {
      final prompt = ''' in json format
      Generate a diet plan for $day with a budget of rupees ${_budgetController.text}, considering allergies to ${_nutAllergiesController.text}. 
      Include only 3 Indian meals (breakfast, lunch, dinner) without the recipe or the cost of any meal. Make sure to suggest entirely different meals, not just toppings, every day, make it creative.
      Format each meal as follows:
      Day " ":
      Breakfast:
      - Meal Name: [Meal Name]
      - Calories: [Calories]
      - Protein: [Protein]g
      - Carbs: [Carbs]g
      - Fats: [Fats]g
      Lunch:
      - Meal Name: [Meal Name]
      - Calories: [Calories]
      - Protein: [Protein]g
      - Carbs: [Carbs]g
      - Fats: [Fats]g
      Dinner:
      - Meal Name: [Meal Name]
      - Calories: [Calories]
      - Protein: [Protein]g
      - Carbs: [Carbs]g
      - Fats: [Fats]g
      No need for any extra snacks or meals.
      ''';
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      print("Response for $day: ${response.text}");
      weeklyDietPlan[day] = _processResponse(response.text ?? '');
    }

    return weeklyDietPlan;
  }

  Map<String, dynamic> _processResponse(String responseText) {
    // Remove any non-JSON text from the response
    final cleanedResponse = responseText.replaceAll(RegExp(r'```json|```'), '').trim();

    Map<String, dynamic> dietPlan = {};

    try {
      // Decode the cleaned JSON response
      final Map<String, dynamic> jsonResponse = jsonDecode(cleanedResponse);

      // Iterate over the days in the response
      jsonResponse.forEach((day, meals) {
        final Map<String, dynamic> dayMeals = {};
        (meals as Map<String, dynamic>).forEach((mealType, mealDetails) {
          dayMeals[mealType] = {
            'Meal Name': mealDetails['Meal Name'],
            'Calories': int.tryParse(mealDetails['Calories']) ?? 0,
            'Protein': int.tryParse(mealDetails['Protein'].replaceAll('g', '')) ?? 0,
            'Carbs': int.tryParse(mealDetails['Carbs'].replaceAll('g', '')) ?? 0,
            'Fats': int.tryParse(mealDetails['Fats'].replaceAll('g', '')) ?? 0,
          };
        });
        dietPlan[day] = dayMeals;
      });

      // Debug print to verify processed data
      print('Processed Diet Plan: $dietPlan');
    } catch (e) {
      print('Error processing response: $e');
    }

    return dietPlan;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Diet Preferences',
          style: TextStyle(
            color: Colors.white
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
                const Text(
                  'Budget',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 10),
                // Budget TextField
                TextFormField(
                  controller: _budgetController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Enter your budget',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E), // Field background
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a budget per meal:';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                
                const Text(
                  'Nut Allergies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 10),
                // Nut Allergies TextField
                TextFormField(
                  controller: _nutAllergiesController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Specify nut allergies',
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
                      return 'Please specify any nut allergies';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                
                // Send Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final processedDietPlan = await _generateDietPlan();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DietPlanPage(dietPlan: processedDietPlan),
                          ),
                        );
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}