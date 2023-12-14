import 'package:flutter/material.dart';
import 'package:qmail/reusable/customButton.dart';
import 'package:qmail/reusable/otpField.dart';
import 'package:qmail/reusable/roundButtons.dart';
import 'package:qmail/reusable/textFieldnoicon.dart';
import 'package:animate_gradient/animate_gradient.dart';

class home3 extends StatelessWidget {
  const home3({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.black38,
          Color(0XFF0E26A6),
          Colors.white38,
        ],
        secondaryColors: const [
          Color(0XFF0E26A6),
          Colors.white38,
          Color(0XFF000729),
        ],
        duration: Duration(seconds: 20),
        child: Stack(children: [
          Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  child: Column(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              top: height * 0.25, right: width * 0.4),
                          child: Text(
                            'Register',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 35,
                              fontFamily: "Fahkwang",
                            ),
                          )),
// RoundButtons(btnText: '↩', onpressed: (){}),

                      Container(
                        padding: const EdgeInsets.only(top: 10, left: 37),
                        child: Column(
                          children: <Widget>[
                            const TextInputWidgetnoIcon(
                                labelText: 'Email', hiddenText: false),
                            const TextInputWidgetnoIcon(
                                labelText: 'Password', hiddenText: true),
                            const TextInputWidgetnoIcon(
                                labelText: 'Confirm Password',
                                hiddenText: true),
                            MyButton(
                                btnText: 'SIGN UP',
                                widthh: 250,
                                lengthh: 50,
                                onpressed: () {},
                                tPad: 30,
                                lPad: 11),
                          ],
                        ),
                      ),
// Container(height: 200,)
                    ],
                  ),
                ),
              ],
            )),
          )
        ]));
  }
}
