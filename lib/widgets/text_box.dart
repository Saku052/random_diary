import 'package:flutter/material.dart';

const TextStyle _textStyle = TextStyle(
    color: Color(0xFFFEFAE0),
    fontSize: 14,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class TextBox extends StatelessWidget {
  const TextBox(this.itemName, {super.key});
  final String itemName;

  static const String demoText =
      'Woke up tired but took a walk to boost energy. Productive brainstorming at work, caught up with a friend over lunch, worked on personal projects. Felt a bit overwhelmed by tasks.';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 800,
          height: 350,
          margin: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFBC6C25),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            itemName,
            style: _textStyle,
          ),
        ),
      ],
    );
  }
}
