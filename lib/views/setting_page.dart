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
  bool _isApi = true;

  void saveapi(String api, String des) {
    setState(() {
      const FlutterSecureStorage storage = FlutterSecureStorage();
      storage.write(key: 'api', value: api);
      storage.write(key: 'des', value: des);
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

  void changeInputState() {
    setState(() {
      _isApi = !_isApi;
    });
  }

  Widget settingsMain() {
    if (_isApi) {
      return SettingsTextfield(saveapi, changeInputState, 'api', 'database ID');
    } else {
      return SettingsTextfield(saveapi, changeInputState, 'name', 'date');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SettingsBanner(widget.changePage),
        settingsMain(),
        PropertiesDropdown(saveDate, saveDescription),
      ],
    );
  }
}
