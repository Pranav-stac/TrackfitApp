import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/DishRecommend.dart';
import 'package:health_app/Forms/CalorieFinder.dart';
import 'package:health_app/Forms/NewDietPlan.dart';
import 'package:health_app/Forms/PhotoCalorieTracker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class DietPlanPage extends StatefulWidget {
  final Map<String, dynamic> dietPlan; // Accept diet plan data

  const DietPlanPage({super.key, required this.dietPlan});

  @override
  State<DietPlanPage> createState() => _DietPlanPageState();
}

class _DietPlanPageState extends State<DietPlanPage> {
  @override
  Widget build(BuildContext context) {
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
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Weekly Diet Plan',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 20),

              // List View for Days of the Week
              Expanded(
                child: ListView.builder(
                  itemCount: 7, // Days of the week
                  itemBuilder: (context, index) {
                    final dayKey = 'Day ${index + 1}';
                    final dayPlan = widget.dietPlan[dayKey] ?? {};
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the dish recommendations page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DishRecommendationsPage(day: dayKey, dayPlan: dayPlan),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A3D37), // Background color
                          border: Border.all(color: const Color(0xFF00FFE0)), // Border color
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          dayKey,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Satoshi',
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 20),

              // Additional Buttons (Grey with iOS right arrow)
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> NewDietPlan()));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3A), // Grey background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 60, // Height for each button
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Make a new Diet Plan',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                      Icon(
                        CupertinoIcons.right_chevron,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CalorieFinder()));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF3A3A3A), // Grey background
                    borderRadius: BorderRadius.circular(12),
                  ),
                  height: 60, // Height for each button
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Calorie Finder',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Satoshi',
                        ),
                      ),
                      Icon(
                        CupertinoIcons.right_chevron,
                        color: Colors.white,
                      ),
                    ],
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

class ImageCaptureScreen extends StatefulWidget {
  @override
  _ImageCaptureScreenState createState() => _ImageCaptureScreenState();
}

class _ImageCaptureScreenState extends State<ImageCaptureScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      _sendImageToServer(_image!);
    }
  }

  Future<void> _sendImageToServer(File image) async {
    final request = http.MultipartRequest('POST', Uri.parse('YOUR_API_ENDPOINT'));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      _displayResults(responseBody);
    } else {
      // Handle error
    }
  }

  void _displayResults(String results) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Results'),
        content: Text(results),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Capture or Pick Image')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) Image.file(_image!),
            ElevatedButton(
              onPressed: () => _pickImage(ImageSource.gallery),
              child: Text('Pick from Gallery'),
            ),
          ],
        ),
      ),
    );
  }
}