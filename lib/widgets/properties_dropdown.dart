import 'package:flutter/material.dart';
import 'package:random_diary/models/diary_model.dart';
import 'package:random_diary/models/request_diary.dart';

class PropertiesDropdown extends StatefulWidget {
  const PropertiesDropdown(this.setProperty, {super.key});
  final void Function(String, String, String, String) setProperty;

  @override
  State<PropertiesDropdown> createState() => _PropertiesDropdownState();
}

class _PropertiesDropdownState extends State<PropertiesDropdown> {
  final RequestDiary requestDiary = RequestDiary();
  late Future<List<NameType>> _items;

  NameType? _selectProperty;
  String? dropdownValue;
  int listNum = 0;

  void selectName(NameType? newValue) {
    setState(() {
      _selectProperty = newValue!;
      print('Selected: ${_selectProperty!.name}');
    });
  }

  DropdownMenuItem<NameType> dropDisplay(NameType value) {
    return DropdownMenuItem<NameType>(
      value: value,
      child: Text(value.name),
    );
  }

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
                onChanged: selectName,
                items: snapshot.data!.map(dropDisplay).toList(),
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
