import 'package:flutter/material.dart';
import 'package:random_diary/item_model.dart';
import 'package:random_diary/diary_repository.dart';

class GradientContainer extends StatefulWidget {
  const GradientContainer({super.key});

  @override
  State<GradientContainer> createState() => _GradientContainerState();
}

class _GradientContainerState extends State<GradientContainer> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Item>> _items;
  String _displayText = '';

  @override
  void initState() {
    super.initState();
    _items = DiaryRepository().getItems();
  }

  void writeData() {
    setState(() {
      _displayText = _controller.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.blue,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: FutureBuilder<List<Item>>(
              future: _items,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text('Data: ${snapshot.data![4].name}');
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
          const SizedBox(height: 100),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Enter your data',
              hintStyle: TextStyle(color: Colors.white),
            ),
          ),
          MaterialButton(
            onPressed: writeData,
            color: Colors.white,
            child: const Text('Add Data'),
          )
        ],
      ),
    ));
  }
}
