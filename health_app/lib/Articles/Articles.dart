import 'package:flutter/material.dart';
import 'package:health_app/Articles/ArticleRecommended.dart';
import 'package:health_app/Articles/Video.dart';

class ArticlesPage extends StatefulWidget {
  const ArticlesPage({super.key});

  @override
  State<ArticlesPage> createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this); // Set the number of tabs
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        // title: const Text('Articles'),
        backgroundColor: const Color(0xFF0A0A0A),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Color(0xFF00FFE0), // Make the indicator transparent
          dividerColor: Colors.transparent,
          unselectedLabelColor: Colors.white,
          labelColor: Colors.white,
          labelStyle: TextStyle(
            fontFamily: 'Satoshi'
            
          ),
          tabs: const [
            Tab(text: 'Videos'),
            Tab(text: 'Articles'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          VideoPage(), // Replace with your actual Video page widget
          ArticleRecommended(), // Replace with your actual ArticleRecommended page widget
        ],
      ),
    );
  }
}
