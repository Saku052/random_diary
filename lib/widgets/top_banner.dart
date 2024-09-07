import 'package:flutter/material.dart';

const Color mainColor = Color(0xFFE3DFC8);
const TextStyle textStyle = TextStyle(
    color: Color(0xFFE3DFC8),
    fontSize: 21,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class TopBanner extends StatelessWidget {
  const TopBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        // container properties
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.fromLTRB(12, 36, 12, 18),

        // container child
        child: Row(
          children: [
            // date of the day
            const Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(radius: 30, backgroundColor: mainColor),
                Text('6', style: textStyle),
              ],
            ),
            const SizedBox(width: 18),

            // the month and day of the week
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('July', style: textStyle),
                Text('Thursday', style: textStyle),
              ],
            ),
            const Spacer(),

            // settings button
            GestureDetector(
                onTap: () {},
                child: const Icon(Icons.settings, color: mainColor, size: 45)),
          ],
        ));
  }
}
