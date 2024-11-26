import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart'; // For iOS-style back button
import 'package:health_app/ProfileSetup/ProfileSetup/CurrentAge.dart';
import 'package:health_app/ProfileSetup/ProfileSetup/CurrentBio.dart';
import 'package:health_app/ProfileSetup/ProfileSetup/CurrentWeight.dart';
import 'package:health_app/ProfileSetup/ProfileSetup/DietPref.dart';
import 'package:health_app/ProfileSetup/ProfileSetup/FitnessGoalPage.dart';
import 'package:health_app/ProfileSetup/ProfileSetup/GoalWeight.dart';
import 'package:http/http.dart' as http;
import 'package:health_app/Navbar.dart';



class ProfileSetup extends StatefulWidget {
  @override
  _ProfileSetupState createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetup> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int totalPages = 5; // Total number of pages

  // Map to store data from each page
  final Map<String, dynamic> _profileData = {};

  void _nextPage() {
    if (_currentPage < totalPages) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentPage++;
      });
    } else {
      // Save the collected data
      _saveProfileData();
      // Navigate to HomePage on finishing setup
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    }
  }

  Future<void> _saveProfileData() async {
    // Create a PersonalInfo object from the collected data
    PersonalInfo info = PersonalInfo(
      currentHeight: _profileData['height'],
      currentWeight: _profileData['currentWeight'],
      goalWeight: _profileData['goalWeight'],
      fitnessGoal: _profileData['fitnessGoal'].toString(),
      dietPreference: _profileData['dietPref'].toString(),
    );

    // Send the data to the server
    try {
      await addPersonalInfo(info);
      print("Profile data saved successfully.");
    } catch (e) {
      print("Failed to save profile data: $e");
    }
  }

  Future<void> addPersonalInfo(PersonalInfo info) async {
    final response = await http.post(
      Uri.parse('https://stable-simply-porpoise.ngrok-free.app/personal-info/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(info.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add personal info');
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A), // Match the background color
        elevation: 0, // Remove the shadow for a flat look
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(CupertinoIcons.back, color: Colors.white), // iOS style back icon
                onPressed: _previousPage, // Goes to previous page
              )
            : const Icon(
                Icons.arrow_back_ios,
                color: Colors.transparent,
              ), // Don't show back button on the first page
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            LinearProgressIndicator(
              value: (_currentPage + 1) / (totalPages + 1),
              backgroundColor: Colors.grey[800],
              color: const Color(0xFF00FFE0),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(), // Disable swipe
                children: [
                  FitnessGoalPage(onNext: _nextPage, onSave: (data) => _profileData['fitnessGoal'] = data),
                  CurrentAge(onNext: _nextPage, onSave: (data) => _profileData['age'] = data),
                  CurrentBio(onNext: _nextPage, onSave: (data) => _profileData['height'] = data),
                  CurrentWeight(onNext: _nextPage, onSave: (data) => _profileData['currentWeight'] = data),
                  GoalWeight(onNext: _nextPage, onSave: (data) => _profileData['goalWeight'] = data),
                  DietPref(onNext: _nextPage, onSave: (data) => _profileData['dietPref'] = data),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 8.0), // Reduced padding to avoid overflow
        child: BottomAppBar(
          color: const Color(0xFF0A0A0A),
          child: Column(
            mainAxisSize: MainAxisSize.min,
          ),
        ),
      ),
    );
  }
}

class PersonalInfo {
  final int? id;
  final double? currentHeight;
  final double? currentWeight;
  final double? goalWeight;
  final String? fitnessGoal;
  final String? dietPreference;

  PersonalInfo({
    this.id,
    this.currentHeight,
    this.currentWeight,
    this.goalWeight,
    this.fitnessGoal,
    this.dietPreference,
  });

  factory PersonalInfo.fromJson(Map<String, dynamic> json) {
    return PersonalInfo(
      id: json['id'],
      currentHeight: json['current_height'],
      currentWeight: json['current_weight'],
      goalWeight: json['goal_weight'],
      fitnessGoal: json['fitness_goal'],
      dietPreference: json['diet_preference'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'current_height': currentHeight,
      'current_weight': currentWeight,
      'goal_weight': goalWeight,
      'fitness_goal': fitnessGoal,
      'diet_preference': dietPreference,
    };
  }
}