import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
    color: Color(0xFFE3DFC8),
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: <Widget>[
        Text('Setting Page', style: _textStyle),
        Text('This is the setting page', style: _textStyle),
        Text('This is the bottom of the setting page', style: _textStyle),
      ],
    );
  }
}
