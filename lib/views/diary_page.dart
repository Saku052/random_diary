import 'package:flutter/material.dart';
import 'package:random_diary/widgets/top_banner.dart';

const TextStyle _textStyle = TextStyle(
    color: Color(0xFFE3DFC8),
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class DiaryPage extends StatefulWidget {
  const DiaryPage({super.key});

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        TopBanner(),
        Text('This is the diary page', style: _textStyle),
        Text('This is the bottom of the diary page', style: _textStyle),
      ],
    );
  }
}
