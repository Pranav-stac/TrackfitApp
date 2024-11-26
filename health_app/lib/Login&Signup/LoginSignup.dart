import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:health_app/Login&Signup/Login.dart';
import 'package:health_app/Login&Signup/Signup.dart';


class LoginSignupPage extends StatefulWidget {
  const LoginSignupPage({super.key});

  @override
  State<LoginSignupPage> createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // 2 Tabs
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back, color: Colors.white), // White iOS back button
          onPressed: () {
            Navigator.pop(context); // Go back
          },
        ),
      ),
      body: Column(
        children: [
          // TabBar at the top
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0xFF00FFE0),
            labelColor: const Color(0xFF00FFE0),
            unselectedLabelColor: Colors.white54,
            dividerColor: Colors.transparent,
            labelStyle: const TextStyle(
              fontFamily: 'Satoshi',
              fontSize: 16,
              fontWeight: FontWeight.bold, // Bold text for tabs
            ),
            tabs: const [
              Tab(text: 'Login'),
              Tab(text: 'Signup'),
            ],
          ),
          // TabBarView content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                LoginPage(),  // Login form in its own page
                SignupPage(), // Signup form in its own page
              ],
            ),
          ),
        ],
      ),
    );
  }
}
