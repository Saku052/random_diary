import 'package:flutter/material.dart';

const Color textColor = Color(0xFF606C38);
const TextStyle _textStyle = TextStyle(
    color: textColor,
    fontSize: 36,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class SettingsBanner extends StatelessWidget {
  const SettingsBanner(this.changePage, {super.key});
  final void Function() changePage;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(18),
        child: Row(
          children: <Widget>[
            const Spacer(),
            const Text('Settings', style: _textStyle),
            const Spacer(),
            GestureDetector(
              onTap: changePage,
              child: const Icon(Icons.backspace, color: textColor, size: 55),
            ),
          ],
        ));
  }
}
