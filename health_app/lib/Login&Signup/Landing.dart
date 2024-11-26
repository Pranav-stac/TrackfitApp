import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/Login&Signup/LoginSignup.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left
          children: [
            // Top image covering 75% of the screen
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/gym.png'))
                )
              ),
            ),
            // "TrackFit Health Assistant" text
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
              child: Text(
                'TrackFit Health Assistant',
                style: TextStyle(
                  color: Color(0xFF00FFE0),
                  fontSize: 20,
                  fontFamily: 'Satoshi',
                  
                ),
                textAlign: TextAlign.left,
              ),
            ),
            // "Welcome to your Ultimate Health Companion" text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Welcome to your Ultimate Health Companion',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontFamily: 'Satoshi',
                ),
                textAlign: TextAlign.left, // Align to the left
              ),
            ),
            SizedBox(height: 30), // Adding some space between text and button
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginSignupPage()));
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.symmetric(vertical: 15.0),
                decoration: BoxDecoration(
                  color: Color(0xFF00FFE0), // Full button color
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'GET STARTED',
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 18,
                        fontFamily: 'Satoshi',
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    SizedBox(width: 10),
                    // Icon(
                    //   CupertinoIcons.right_chevron,
                    //   color: Colors.black, // Icon color to match text
                    // ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40), // Space at the bottom
          ],
        ),
      ),
    );
  }
}
