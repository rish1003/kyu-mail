import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String btnText;
  final double widthh;
  final double lengthh;
  final Function() onpressed;
  final double tPad;
  final double lPad;

  const MyButton({super.key,
    required this.btnText,
    required this.widthh,
    required this.lengthh,
    required this.onpressed,
    required this.tPad,
    required this.lPad,


  });




  @override
  Widget build(BuildContext context){
    return Padding(padding: EdgeInsets.only(top: tPad,left: lPad),

        child:OutlinedButton(

            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white70, minimumSize: Size(widthh, lengthh),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
            onPressed: onpressed,
            child: Text(btnText))
    );

  }
}