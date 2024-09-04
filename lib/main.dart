import 'package:flutter/material.dart';
import 'package:random_diary/diary_ver1/gradient_container.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GradientContainer(),
    );
  }
}
