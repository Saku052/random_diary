import 'package:flutter/material.dart';

class SettingsTextfield extends StatelessWidget {
  SettingsTextfield(this.setApi, this.setDes, this.input1, this.input2,
      {super.key});
  final void Function(String) setApi;
  final void Function(String) setDes;
  final String input1;
  final String input2;

  final TextEditingController apiController = TextEditingController();
  final TextEditingController desController = TextEditingController();

  InputDecoration fieldDecoration(String label) => InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Color(0xFFFEFAE0)),
        fillColor: const Color(0xFFDDA15E), // Set background color
        filled: true,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(18),
      child: Column(
        children: <Widget>[
          TextField(
            controller: apiController,
            decoration: fieldDecoration(input1),
            onSubmitted: (value) {
              setApi(value);
            },
          ),
          const SizedBox(height: 15),
          TextField(
            controller: desController,
            decoration: fieldDecoration(input2),
            onSubmitted: (value) {
              setDes(value);
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
