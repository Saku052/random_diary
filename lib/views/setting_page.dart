import 'package:flutter/material.dart';
import 'package:random_diary/widgets/properties_dropdown.dart';
import 'package:random_diary/widgets/settings_banner.dart';
import 'package:random_diary/widgets/settings_textfield.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const Color textColor = Color(0xFF606C38);
const TextStyle _textStyle = TextStyle(
    color: Color(0xFFE3DFC8),
    fontSize: 18,
    fontWeight: FontWeight.bold,
    fontFamily: 'Roboto');

class SettingPage extends StatefulWidget {
  const SettingPage(this.changePage, {super.key});
  final void Function() changePage;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String _currentApi = '';
  String _currentDes = '';

  void saveapi(String api) {
    setState(() {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      storage.write(key: 'api', value: api);
      _currentApi = api;
    });
  }

  void saveDes(String des) {
    setState(() {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      storage.write(key: 'des', value: des);
      _currentDes = des;
    });
  }

  void saveDate(String date, String dateType) {
    setState(() {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      storage.write(key: 'date', value: date);
      storage.write(key: 'dateType', value: dateType);
    });
  }

  void saveDescription(String description, String descriptionType) {
    setState(() {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      storage.write(key: 'description', value: description);
      storage.write(key: 'descriptionType', value: descriptionType);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SettingsBanner(widget.changePage),
        SettingsTextfield(saveapi, saveDes, 'api', 'database ID'),
        PropertiesDropdown(
          saveDate,
          saveDescription,
          key: ValueKey('$_currentApi-$_currentDes'),
        ),
      ],
    );
  }
}
