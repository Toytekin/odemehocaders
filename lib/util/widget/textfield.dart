// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SbtTextField extends StatelessWidget {
  final bool keybordTypr;
  final TextEditingController controller;
  final String label;
  final Widget widget;

  const SbtTextField({
    Key? key,
    required this.keybordTypr,
    required this.controller,
    required this.label,
    required this.widget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType:
            keybordTypr ? TextInputType.multiline : TextInputType.number,
        controller: controller,
        decoration: InputDecoration(
          suffixIcon: widget,
          label: Text(label),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
