import 'package:flutter/material.dart';
import 'dart:convert'; // Import for JSON decoding

class DishRecommendationsPage extends StatelessWidget {
  final String day;
  final Map<String, dynamic> dayPlan;

  const DishRecommendationsPage({super.key, required this.day, required this.dayPlan});

  @override
  Widget build(BuildContext context) {
    print('Day: $day');
    print('Day Plan: $dayPlan'); // Debug print to check the data

    // Access the meals for the specified day
    final meals = dayPlan[day] as Map<String, dynamic>? ?? {};

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A), // Background color
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          '$day Recommendations',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Satoshi',
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: meals.isNotEmpty
              ? ListView(
                  children: meals.entries.map((entry) {
                    final meal = entry.value as Map<String, dynamic>;
                    return _buildDishContainer(
                      title: entry.key,
                      dishName: meal['Meal Name'] ?? 'Unknown',
                      calories: meal['Calories'] ?? 0,
                      protein: meal['Protein'] ?? 0,
                      carbs: meal['Carbs'] ?? 0,
                      fats: meal['Fats'] ?? 0,
                      imageUrl: 'https://via.placeholder.com/150', // Placeholder image
                    );
                  }).toList(),
                )
              : Center(
                  child: Text(
                    'No data available for $day',
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildDishContainer({
    required String title,
    required String dishName,
    required int calories,
    required int protein,
    required int carbs,
    required int fats,
    required String imageUrl,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16), // Added padding inside the container
      decoration: BoxDecoration(
        color: const Color(0xFF292929), // Container background color
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey,
                  child: const Icon(Icons.error, color: Colors.red),
                );
              },
            ),
          ),
          const SizedBox(width: 20),
          // Dish Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$dishName - $calories kcal',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Satoshi',
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Protein: $protein g',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: 'Satoshi',
                  ),
                ),
                Text(
                  'Carbs: $carbs g',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: 'Satoshi',
                  ),
                ),
                Text(
                  'Fats: $fats g',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: 'Satoshi',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}