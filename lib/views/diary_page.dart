import 'package:flutter/material.dart';
import 'package:random_diary/widgets/top_banner.dart';
import 'package:random_diary/widgets/text_box.dart';
import 'package:random_diary/models/request_diary.dart';
import 'package:random_diary/models/diary_model.dart';
import 'dart:math';

class DiaryPage extends StatefulWidget {
  const DiaryPage(this.changePage, {super.key});
  final void Function() changePage;

  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class _DiaryPageState extends State<DiaryPage> {
  late Future<List<Diary>> _items;
  final RequestDiary requestDiary = RequestDiary();

  int getNum(int? listLength) {
    final random = Random();
    if (listLength == null) {
      return 0;
    }
    final randomNumber = random.nextInt(listLength);
    return randomNumber;
  }

  @override
  void initState() {
    setState(() {
      _items = requestDiary.getDiary();
    });
    super.initState();
  }

  void reload() {
    setState(() {});
  }

  void disposehttp() {
    requestDiary.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TopBanner(widget.changePage),
        FutureBuilder<List<Diary>>(
          future: _items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              disposehttp;
              return TextBox(
                  snapshot.data![getNum(snapshot.data!.length)].description);
            } else if (snapshot.hasError) {
              return TextBox(snapshot.error.toString());
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        const SizedBox(height: 30),
        GestureDetector(
          onTap: reload,
          child: const Icon(Icons.redo, color: textColor, size: 100),
        ),
      ],
    );
  }
}
