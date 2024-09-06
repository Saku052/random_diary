import 'package:flutter/material.dart';
import 'package:random_diary/views/diary_framework.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: DiaryFramework(),
    );
  }
}
