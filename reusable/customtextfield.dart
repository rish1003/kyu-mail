import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final List<String> list1;

   CustomTextField(
      {super.key, required this.controller, required this.list1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
          color: Color(0xFFD8D8D8),
          fontSize: 18.0), // Set the text color
      cursorColor: Color(0xFFD8D8D8),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors
            .transparent, // Set the background color to transparent
        border: InputBorder.none,
      ),
      controller: controller,
      onSubmitted: (value) {
        list1.add(value);
        controller.clear();
      },
    );
  }
}
