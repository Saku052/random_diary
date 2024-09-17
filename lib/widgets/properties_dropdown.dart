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

  NameType? _selectDate;
  NameType? _selectDescription;
  String? dropdownValue;
  int listNum = 0;

  void selectDate(NameType? newValue) {
    setState(() {
      _selectDate = newValue!;
      print('Selected: ${_selectDate!.name}');
    });
  }

  void selectDescription(NameType? newValue) {
    setState(() {
      _selectDescription = newValue!;
      print('Selected: ${_selectDescription!.name}');
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
    return Row(
      children: <Widget>[
        const Spacer(),
        FutureBuilder<List<NameType>>(
          future: _items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              disposehttp;
              return DropdownButton<NameType>(
                hint: const Text('description'),
                value: _selectDescription,
                onChanged: selectDescription,
                items: snapshot.data!.map(dropDisplay).toList(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        const Spacer(),
        FutureBuilder<List<NameType>>(
          future: _items,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              disposehttp;
              return DropdownButton<NameType>(
                hint: const Text('date'),
                value: _selectDate,
                onChanged: selectDate,
                items: snapshot.data!.map(dropDisplay).toList(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        const Spacer(),
      ],
    );
  }
}
