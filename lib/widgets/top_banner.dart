import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const Color backGround = Color(0xFFFEFAE0);
const Color containerColor = Color(0xFFBC6C25);
const Color textColor = Color(0xFF606C38);

TextStyle transTextStyle(double size) => TextStyle(
    color: backGround,
    fontSize: size,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');
const TextStyle mainTextStyle = TextStyle(
    color: textColor,
    fontSize: 27,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class TopBanner extends StatelessWidget {
  const TopBanner(this.changePage, this.date, {super.key});
  final void Function() changePage;
  final DateTime date;

  String getDay() => date.day.toString();
  String getMonth() => DateFormat.MMMM().format(date);
  String getWeekDay() => DateFormat.EEEE().format(date);

  String getDaysAgo() {
    final now = DateTime.now();
    final diff = now.difference(date);
    final daysAgo = diff.inDays;
    return daysAgo.toString();
  }

  Widget getDaysAgoWidget() {
    final daysAgo = getDaysAgo();
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 240,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF606C38),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        Text('$daysAgo days ago', style: transTextStyle(18.0)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // container properties
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.fromLTRB(12, 36, 12, 36),

      // container child
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // date of the day
              Stack(
                alignment: Alignment.center,
                children: [
                  const CircleAvatar(
                      radius: 40, backgroundColor: containerColor),
                  Text(getDay(), style: transTextStyle(32)),
                ],
              ),
              const SizedBox(width: 18),

              // the month and day of the week
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getMonth(), style: mainTextStyle),
                  Text(getWeekDay(), style: mainTextStyle),
                ],
              ),
              const Spacer(),

              // settings button
              GestureDetector(
                onTap: changePage,
                child: const Icon(Icons.settings, color: textColor, size: 60),
              ),
            ],
          ),
          const SizedBox(height: 26),
          getDaysAgoWidget(),
        ],
      ),
    );
  }
}
