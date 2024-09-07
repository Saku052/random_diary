import 'package:flutter/material.dart';

const Color backGround = Color(0xFFFEFAE0);
const Color containerColor = Color(0xFFBC6C25);
const Color textColor = Color(0xFF606C38);

const TextStyle transTextStyle = TextStyle(
    color: backGround,
    fontSize: 27,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');
const TextStyle mainTextStyle = TextStyle(
    color: textColor,
    fontSize: 27,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class TopBanner extends StatelessWidget {
  const TopBanner(this.changePage, {super.key});
  final void Function() changePage;

  @override
  Widget build(BuildContext context) {
    return Container(
        // container properties
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(12, 36, 12, 36),

        // container child
        child: Row(
          children: [
            // date of the day
            const Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(radius: 40, backgroundColor: containerColor),
                Text('6', style: transTextStyle),
              ],
            ),
            const SizedBox(width: 18),

            // the month and day of the week
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('July', style: mainTextStyle),
                Text('Thursday', style: mainTextStyle),
              ],
            ),
            const Spacer(),

            // settings button
            GestureDetector(
              onTap: changePage,
              child: const Icon(Icons.settings, color: textColor, size: 60),
            ),
          ],
        ));
  }
}
