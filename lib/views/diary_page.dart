import 'package:flutter/material.dart';
import 'package:random_diary/widgets/top_banner.dart';
import 'package:random_diary/widgets/text_box.dart';
import 'package:random_diary/models/request_diary.dart';
import 'package:random_diary/models/diary_model.dart';
import 'package:random_diary/models/send_diary.dart';
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
  final SendDiary sendDiary = SendDiary();

  int listNum = 0;

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
        FutureBuilder<List<Diary>>(
          future: _items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              disposehttp;
              listNum = getNum(snapshot.data!.length);
              return Column(
                children: [
                  TopBanner(widget.changePage, snapshot.data![listNum].date),
                  TextBox(snapshot.data![listNum].description),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  TopBanner(widget.changePage, DateTime.now()),
                  TextBox(snapshot.error.toString()),
                ],
              );
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
        GestureDetector(
          onTap: () => sendDiary.sendDiaryToNotion(
              Diary(date: DateTime.now(), description: 'test')),
          child: const Icon(Icons.send, color: textColor, size: 100),
        ),
      ],
    );
  }
}
