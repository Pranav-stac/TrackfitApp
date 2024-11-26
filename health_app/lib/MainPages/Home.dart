import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:health_app/Diet.dart';
import 'package:health_app/Exercise.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(37.42796133580664, -122.085749655962); // Example coordinates

  @override
  Widget build(BuildContext context) {
    // Get the screen width
    final double screenWidth = MediaQuery.of(context).size.width;
    // Calculate box width to maintain a gap of 10 pixels
    final double boxWidth = (screenWidth - 50) / 2; // 30 = 10 (gap) + 10 (gap) + 10 (padding)

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 10, 10),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                'Hello Again, Rahul.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "It's good to see you come back",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Satoshi',
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExercisePage()));
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFAE00),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Run it off!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'View your exercise plans here.',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/run.png',
                        height: 80,
                        width: 80,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: boxWidth,
                    height: boxWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFF161616),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: boxWidth * 0.85,
                            height: boxWidth * 0.85,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF9466FF),
                                width: 8,
                              ),
                            ),
                          ),
                          Container(
                            width: boxWidth * 0.65,
                            height: boxWidth * 0.65,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFF00E9CD),
                                width: 8,
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                '240 kcal',
                                style: TextStyle(
                                  color: Color(0xFF9466FF),
                                  fontSize: 18,
                                  fontFamily: 'Satoshi',
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '7265 steps',
                                style: TextStyle(
                                  color: Color(0xFF00E9CD),
                                  fontSize: 16,
                                  fontFamily: 'Satoshi',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: boxWidth,
                    height: boxWidth,
                    decoration: BoxDecoration(
                      color: const Color(0xFF00FF62),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            '90',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 38,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Sleep Score',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Satoshi',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => DietPlanPage(dietPlan: {},)));
                },
                child: Container(
                  width: double.infinity,
                  height: 150,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00FFE0),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Savor the Flavor!',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'View your diet plans here.',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'Satoshi',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/fork.png',
                        height: 80,
                        width: 80,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title for the map section
              const Text(
                'Your Latest Run',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontFamily: 'Satoshi',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10), // Space below the title
              // Google Map Placeholder
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF292929), // Dark background for the graph
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GoogleMap(
                  onMapCreated: (GoogleMapController controller) {
                    mapController = controller;
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(19.075983, 72.877655), // Mumbai coordinates
                    zoom: 15.0, // Default zoom level
                  ),
                  myLocationEnabled: true, // Enable location tracking
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}