import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:health_app/Articles/Articles.dart';
import 'package:health_app/MainPages/Community.dart';
import 'package:health_app/MainPages/VoiceBot.dart';
import 'MainPages/Home.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0; // Index for the currently selected page

  final List<Widget> _pages = [
    HomePage(),
    CommunityPage(),
    VoiceBotPage(),
    ArticlesPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display the selected page
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF292929),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_rounded),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Articles',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFF00FFE0), // Highlight color for selected item
        unselectedItemColor: Colors.white, // Color for unselected items
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(
          fontFamily: 'Satoshi'
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'Satoshi',
      ),
      ),
    );
  }
}
