import 'package:flutter/material.dart';
import 'package:random_diary/views/diary_page.dart';
import 'package:random_diary/views/setting_page.dart';

const Color _backgroundColor = Color(0xFFFEFAE0);

class DiaryFramework extends StatefulWidget {
  const DiaryFramework({super.key});

  @override
  State<DiaryFramework> createState() => _DiaryFrameworkState();
}

class _DiaryFrameworkState extends State<DiaryFramework> {
  Widget? currentPage;

  @override
  void initState() {
    currentPage = DiaryPage(changePage);
    super.initState();
  }

  void changePage() {
    setState(() {
      if (currentPage is DiaryPage) {
        currentPage = const SettingPage();
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
