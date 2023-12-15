import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:studio_projects/auth/registration.dart';
import 'package:studio_projects/screens/home.dart';

import '../reusable/custombutton.dart';
import '../reusable/textfieldnoicon.dart';





class onetimepass extends StatelessWidget {
  onetimepass({super.key});
  final TextEditingController _pinPutController = TextEditingController();
  var otp;
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    final defaultPinTheme = PinTheme(
      width: 43,
      height: 43,
      textStyle: const TextStyle(
          fontSize: 17,
          color: Colors.white54,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(43, 43, 43, 1).withOpacity(0)),
        borderRadius: BorderRadius.circular(50),
        color: const Color.fromRGBO(43, 43, 43, 1).withOpacity(0.3),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );
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
        duration: Duration(seconds:20),
        child:Stack(
            children:[
              Scaffold(
                backgroundColor: Colors.black12,
                body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(

                          child: Column(

                            children: [
                              Padding(padding: EdgeInsets.only(top: height*0.25,right: width*0.4),
                                  child: Text(
                                    'SIGN UP',
                                    style: TextStyle(
                                      color: Colors.white70,
                                      fontSize: 35,
                                      fontFamily: "Fahkwang",
                                    ),
                                  )),
                              // RoundButtons(btnText: '↩', onpressed: (){}),

                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: Column(
                                  children: <Widget>[
                                    TextInputWidgetnoIcon(labelText: 'PHONE', hiddenText: false),
                                    Container(
                                      padding: EdgeInsets.only(top: 30,bottom: 0,right: 255),
                                      child: Text('OTP',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: "Fahkwang-Light",
                                        ),),),
                                    Container(
                                      height: 70,
                                      child:Pinput(
                                        length: 6,
                                        controller: _pinPutController,
                                        defaultPinTheme: defaultPinTheme,
                                        focusedPinTheme: focusedPinTheme,
                                        onCompleted: (String pin) async{
                                          otp = pin;
                                        },
                                      ),),

                                    MyButton(btnText: 'Register', widthh: 250, lengthh: 50, onpressed:(){
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>  registration()),
                                      );}, tPad: 30, lPad: 11),
                                  ],
                                ),
                              ),
                              Container(height: 300,)
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              )
            ]
        ));
  }
}
