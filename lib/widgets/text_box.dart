import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({super.key});

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
        const Text('This is something is somethingsomething',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xFFFEFAE0),
                fontSize: 14,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto')),
      ],
    );
  }
}
