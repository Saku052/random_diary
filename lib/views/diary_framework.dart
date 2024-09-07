import 'package:flutter/material.dart';
import 'package:random_diary/views/diary_page.dart';
import 'package:random_diary/views/setting_page.dart';

const Color _backgroundColor = Color.fromARGB(255, 225, 151, 241);

class DiaryFramework extends StatefulWidget {
  const DiaryFramework({super.key});

  @override
  State<DiaryFramework> createState() => _DiaryFrameworkState();
}

class _DiaryFrameworkState extends State<DiaryFramework> {
  Widget currentPage = const DiaryPage();

  void changeePage() {
    setState(() {
      if (currentPage is DiaryPage) {
        currentPage = const SettingPage();
      } else {
        currentPage = const DiaryPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // container properties
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(15),
      color: _backgroundColor,

      // container child
      child: currentPage,
    ));
  }
}
