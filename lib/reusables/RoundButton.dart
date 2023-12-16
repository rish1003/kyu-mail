import 'package:flutter/material.dart';

class RoundButtons extends StatelessWidget {
  final Icon btnIcon;
  final Function() onpressed;

  const RoundButtons({Key? key,
    required this.btnIcon,
    required this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return FloatingActionButton(
      onPressed: onpressed,
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
      child: btnIcon,
      elevation: 0.0,

    );
  }
}