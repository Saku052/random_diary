import 'package:flutter/material.dart';

class SettingsTextfield extends StatelessWidget {
  SettingsTextfield(
      this.setApi, this.changeInputState, this.input1, this.input2,
      {super.key});
  final void Function(String, String) setApi;
  final void Function() changeInputState;

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
          ),
          const SizedBox(height: 15),
          TextField(
            controller: desController,
            decoration: fieldDecoration(input2),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: () => setApi(apiController.text, desController.text),
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFFEFAE0),
              backgroundColor: const Color(0xFF606C38),
            ),
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
          OutlinedButton.icon(
            onPressed: changeInputState,
            style: OutlinedButton.styleFrom(
              foregroundColor: const Color(0xFFFEFAE0),
              backgroundColor: const Color(0xFFBC6C25),
            ),
            icon: const Icon(Icons.input),
            label: const Text('Input Properties'),
          ),
        ],
      ),
    );
  }
}
