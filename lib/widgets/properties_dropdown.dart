import 'package:flutter/material.dart';
import 'package:random_diary/models/diary_model.dart';
import 'package:random_diary/models/request_diary.dart';

class PropertiesDropdown extends StatefulWidget {
  const PropertiesDropdown({super.key});

  @override
  State<PropertiesDropdown> createState() => _PropertiesDropdownState();
}

class _PropertiesDropdownState extends State<PropertiesDropdown> {
  String? dropdownValue;
  late Future<List<NameType>> _items;
  final RequestDiary requestDiary = RequestDiary();
  int listNum = 0;
  NameType? _selectProperty;

  @override
  void initState() {
    setState(() {
      _items = requestDiary.getProperties();
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
        FutureBuilder<List<NameType>>(
          future: _items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              disposehttp;
              return DropdownButton<NameType>(
                hint: const Text('Select a property'),
                value: _selectProperty,
                onChanged: (NameType? newValue) {
                  setState(() {
                    _selectProperty = newValue!;
                    print('Selected: ${_selectProperty!.name}');
                  });
                },
                items: snapshot.data!.map((NameType value) {
                  return DropdownMenuItem<NameType>(
                    value: value,
                    child: Text(value.name),
                  );
                }).toList(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}
