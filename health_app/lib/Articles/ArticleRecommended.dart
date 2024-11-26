import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleRecommended extends StatefulWidget {
  const ArticleRecommended({super.key});

  @override
  State<ArticleRecommended> createState() => _ArticleRecommendedState();
}

class _ArticleRecommendedState extends State<ArticleRecommended> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
    );
  }
}