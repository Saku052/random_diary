import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:random_diary/diary_repository.dart';
import 'package:random_diary/item_model.dart';

class PropertyTextfield extends StatelessWidget {
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final String nameLabel = 'description property';
  final String dateLabel = 'date property';
  final String nameHint = 'please enter the name of discription property';
  final String dateHint = 'please enter the name of date property';
  final Function(Future<List<Item>>) onGetItems;

  PropertyTextfield({required this.onGetItems});

  void addProperty() async {
    final storage = FlutterSecureStorage();
    await storage.write(key: 'name_prop', value: _nameController.text);
    await storage.write(key: 'date_prop', value: _dateController.text);

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
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: nameLabel,
                    hintText: nameHint,
                  ),
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                child: TextField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: dateLabel,
                    hintText: dateHint,
                  ),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: addProperty,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
            child: const Text('Add property'),
          ),
        ],
      ),
    );
  }
}
