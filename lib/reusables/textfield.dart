import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class textfield extends StatelessWidget {
  final TextEditingController controller;
  textfield({super.key, required this.controller});

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
      maxLines: null,
    );
  }
}