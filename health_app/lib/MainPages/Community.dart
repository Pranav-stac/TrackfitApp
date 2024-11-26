import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final List<String> userNames = [
    'Alice Johnson',
    'David Smith',
    'Emma Williams',
    'Michael Brown',
    'Sophia Garcia',
  ];

  final List<String> captions = [
    'Just completed a 5K run! Feeling stronger every day.',
    'Started a new workout routine today. Excited to see the progress!',
    'Remember, consistency is key! Keep pushing towards your goals.',
    'Loving my new strength training program! Can’t wait to lift heavier!',
    'Just hit my personal best in deadlifts! Hard work pays off.',
  ];

  // List to keep track of heart icon states (clicked or not)
  final List<bool> liked = List.generate(5, (_) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0A0A),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 15.0), // Add padding to leave space above the navbar
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: 5, // Number of posts
            separatorBuilder: (context, index) => Divider(
              color: const Color(0xFF00FFE0), // Bottom border color
              thickness: 1,
            ),
            itemBuilder: (context, index) {
              return _buildPost(
                userNames[index % userNames.length],
                captions[index % captions.length], // Use modulus to cycle through captions
                index,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPost(String userName, String caption, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: const Color(0xFF00FFE0), // Circular icon color
                child: Icon(
                  CupertinoIcons.person,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: const TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF00FFE0), // Primary color
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Student', // or 'Alumni'
                      style: TextStyle(
                        fontFamily: 'Satoshi',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            caption,
            style: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 14,
              color: Color(0xFF00FFE0), // Primary color
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 200, // Height of the post image
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[300], // Placeholder for image
            ),
            child: const Center(
              child: Text('Image Placeholder'),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  liked[index] ? CupertinoIcons.heart_solid : CupertinoIcons.heart,
                  color: liked[index] ? Colors.red : const Color(0xFF00FFE0), // Change to red if liked
                ),
                onPressed: () {
                  setState(() {
                    liked[index] = !liked[index]; // Toggle like status
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}