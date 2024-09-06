import 'package:flutter/material.dart';

const Color _backgroundColor = Color(0xFF453748);
const TextStyle _textStyle = TextStyle(
    color: Color(0xFFE3DFC8),
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class DiaryPage extends StatefulWidget {
  const DiaryPage({Key? key}) : super(key: key);

  @override
  _DiaryPageState createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      // container properties
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(15),
      color: _backgroundColor,

      // container child
      child: const Column(
        children: <Widget>[
          Text('Diary Page', style: _textStyle),
          Text('This is the diary page', style: _textStyle),
          Text('This is the bottom of the diary page', style: _textStyle),
        ],
      ),
    ));
  }
}
