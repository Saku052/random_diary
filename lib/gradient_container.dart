import 'package:flutter/material.dart';
import 'package:random_diary/item_model.dart';
import 'package:random_diary/diary_repository.dart';
import 'package:random_diary/api_key_textfield.dart';
import 'dart:math';

class GradientContainer extends StatefulWidget {
  const GradientContainer({super.key});

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Item>> _items;

  static const Color _backgroundColor = Color(0xFF453748);
  static const Color _textColor = Color(0xFFE3DFC8);

  @override
  void initState() {
    super.initState();
    _items = DiaryRepository().getItems();
  }

  void getItems(Future<List<Item>> items) {
    setState(() {
      _items = items;
    });
  }

  int getRandomNumber(int? listLength) {
    final random = Random();

    if (listLength == null) {
      return 0;
    }
    final randomNumber = random.nextInt(listLength);
    _controller.text = randomNumber.toString();

    return randomNumber;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: _backgroundColor,
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FutureBuilder<List<Item>>(
              future: _items,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    '${snapshot.data![getRandomNumber(snapshot.data?.length)].date}\n${snapshot.data![getRandomNumber(snapshot.data?.length)].description}',
                    style: const TextStyle(color: _textColor),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString(),
                      style: const TextStyle(color: _textColor));
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(height: 32),
          ApiKeyTextField(onGetItems: getItems),
        ],
      ),
    ));
  }
}
