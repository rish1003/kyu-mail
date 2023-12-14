import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String labelText;
  final Icon prefixicon;
  final bool hiddenText;
final double width , height;
  const TextInputWidget({Key? key,
    required this.labelText,
    required this.prefixicon,
    required this.hiddenText, required this.width, required this.height,


  }): super(key: key);



  @override
  Widget build(BuildContext context) {
    TextEditingController NameController = TextEditingController();
    return Column(children: <Widget>[

      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 30.0),
        child: FractionallySizedBox(
            widthFactor: width,
            child: TextField(
              style: const TextStyle(
                color: Colors.white60,
              ),
              obscureText: hiddenText,
              controller:NameController,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38)),
                prefixIconColor: Colors.grey,
                prefixIcon: prefixicon,
                labelText: labelText,



              ),
            )),
      ),

    ]);
  }
}