import 'package:flutter/material.dart';
import 'package:random_diary/models/diary_model.dart';
import 'package:random_diary/models/request_diary.dart';

class PropertiesDropdown extends StatefulWidget {
  const PropertiesDropdown(this.setDate, this.setDescription, {super.key});
  final void Function(String, String) setDate;
  final void Function(String, String) setDescription;

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
    _selectDate = newValue!;
    widget.setDate(_selectDate!.name, _selectDate!.type);
  }

  void selectDescription(NameType? newValue) {
    _selectDescription = newValue!;
    widget.setDescription(_selectDescription!.name, _selectDescription!.type);
  }

  DropdownMenuItem<NameType> dropDisplay(NameType value) {
    return DropdownMenuItem<NameType>(
      value: value,
      child: Text(value.name),
    );
  }

  BoxDecoration dropDecoration() {
    return BoxDecoration(
      color: const Color(0xFFDDA15E),
      borderRadius: BorderRadius.circular(8),
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
        Container(
          decoration: dropDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: FutureBuilder<List<NameType>>(
            future: _items,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                disposehttp;
                return DropdownButton<NameType>(
                  hint: const Text('diary',
                      style: TextStyle(color: Colors.white)),
                  value: _selectDescription,
                  onChanged: selectDescription,
                  items: snapshot.data!.map(dropDisplay).toList(),
                  underline: Container(), // Remove the default underline
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 255, 255, 255)),
                  dropdownColor: const Color(0xFFDDA15E),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        const Spacer(),
        Container(
          decoration: dropDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: FutureBuilder<List<NameType>>(
            future: _items,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                disposehttp;
                return DropdownButton<NameType>(
                  hint:
                      const Text('date', style: TextStyle(color: Colors.white)),
                  value: _selectDate,
                  onChanged: selectDate,
                  items: snapshot.data!.map(dropDisplay).toList(),
                  underline: Container(), // Remove the default underline
                  icon: const Icon(Icons.arrow_drop_down,
                      color: Color.fromARGB(255, 255, 255, 255)),
                  dropdownColor: const Color(0xFFDDA15E),
                  style: const TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255)),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
