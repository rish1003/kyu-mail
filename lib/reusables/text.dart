import 'package:flutter/cupertino.dart';

class mytext extends StatelessWidget {
  final String textip;
  final double fontsize;

  const mytext({super.key, required this.textip, required this.fontsize, });

  @override
  Widget build(BuildContext context) {
    return Text(textip,style: TextStyle(
      fontSize: fontsize,
      color: Color(0xFFD8D8D8),

    ),);
  }
}