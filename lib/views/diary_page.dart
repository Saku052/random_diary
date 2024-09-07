import 'package:flutter/material.dart';
import 'package:random_diary/widgets/top_banner.dart';
import 'package:random_diary/widgets/text_box.dart';

class DiaryPage extends StatefulWidget {
  const DiaryPage(this.changePage, {super.key});
  final void Function() changePage;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopBanner(widget.changePage),
        const TextBox(),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: () {},
          child: const Icon(Icons.redo, color: textColor, size: 100),
        ),
      ],
    );
  }
}
