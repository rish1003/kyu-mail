import 'package:flutter/material.dart';

class TextInputWidgetnoIcon extends StatelessWidget {
  final String labelText;


  final bool hiddenText;

  const TextInputWidgetnoIcon({Key? key,
    required this.labelText,

    required this.hiddenText,



  }): super(key: key);



  @override
  Widget build(BuildContext context) {
    TextEditingController NameController = TextEditingController();

    return Column(children: <Widget>[

      Padding(
        padding: const EdgeInsets.only(left: 10.0, top: 30.0),
        child: Container(
          width: 300,

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

                labelText: labelText,
                labelStyle: const TextStyle(
                  color: Colors.white,
                  fontFamily: "Fahkwang-Light",
                ),



              ),
            )),
      ),

    ]);
  }
}