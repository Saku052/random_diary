import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:random_diary/diary_ver1/diary_repository.dart';
import 'package:random_diary/diary_ver1/item_model.dart';

class ApiKeyTextField extends StatelessWidget {
  final _apiController = TextEditingController();
  final _idController = TextEditingController();
  final String apiLabel = 'API key';
  final String idLabel = 'Database ID';
  final String hintapi = 'Enter your API key';
  final String hintid = 'Enter your Database ID';
  final Function(Future<List<Item>>) onGetItems;

  static const Color _textColor = Color.fromARGB(255, 12, 53, 64);

  ApiKeyTextField({required this.onGetItems});

  void getitems() async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'api_key', value: _apiController.text);
    await storage.write(key: 'database_id', value: _idController.text);

    onGetItems(DiaryRepository().getItems());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        children: [
          TextField(
            controller: _apiController,
            decoration: InputDecoration(
              labelText: apiLabel,
              hintText: hintapi,
            ),
          ),
          TextField(
            controller: _idController,
            decoration: InputDecoration(
              labelText: idLabel,
              hintText: hintapi,
            ),
          ),
          TextButton(
            onPressed: getitems,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
            child: const Text(
              'load your diary',
              style: TextStyle(color: _textColor),
            ),
          ),
        ],
      ),
    );
  }
}
