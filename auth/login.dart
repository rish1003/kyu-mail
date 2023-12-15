import 'package:animate_gradient/animate_gradient.dart';
import 'package:flutter/material.dart';
import 'package:studio_projects/auth/onetimepass.dart';
import 'package:studio_projects/screens/home.dart';

import '../reusable/custombutton.dart';
import '../reusable/icons.dart';
import '../reusable/roundbutton.dart';
import '../reusable/textfieldshrey.dart';







class loginpage extends StatelessWidget {
  const loginpage({super.key});


  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;

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
                backgroundColor: Colors.transparent,

                body:SingleChildScrollView(
                  child:  Container(

                    child:  Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: height*0.20, right: width*0.35),
                          child: Text(
                            'SIGN IN',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: width*0.10,
                              fontFamily: "Fahkwang",

                            ),
                          ),
                        ),
                        TextInputWidget(labelText: 'Enter a Valid Email id', prefixicon: Icon(Icons.mail_outline), hiddenText: false, width: 0.8, height: 0,),
                        TextInputWidget(labelText: 'Enter Your Password',prefixicon: Icon(Icons.lock),hiddenText: true, width:0.8, height: 0,),
                        MyButton(btnText: 'SIGN IN', widthh: 250, lengthh: 50,onpressed: (){

                        }, tPad: 30, lPad: 11,),
                        Container(
                          height: 30,
                        ),
                        Container(
                          child:Row(children: <Widget>[
                            Spacer(),
                            RoundButtons(btnIcon: Icon(HomeIcons.google), onpressed: (){}),
                            Container(
                              width: 20,
                            ),
                            RoundButtons(btnIcon: Icon(HomeIcons.outlook__1_), onpressed: (){}),
                            Spacer(),

                          ],),
                        ),

                        Container(
                          height: 30,
                        ),

                        MyBottomTexts(),
                        MyButton(btnText: 'SIGN UP',widthh: 200, lengthh: 40,onpressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) =>  onetimepass()),
                          );
                        }, tPad: 0, lPad: 11,),

                        //add other widgets,classes
                      ],
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   top: 0,
              //   left: 0,
              //   child: Image.asset('assets/images/moon.png'), // replace with your image
              // ),
            ])
    );
  }


}







class MyBottomTexts extends StatelessWidget{
  const MyBottomTexts({super.key});

  @override
  Widget build(BuildContext context){
    return const Column(children: <Widget>[
      Padding(
        padding: EdgeInsets.only(top: 130,bottom: 10),
        child: Text("DON'T HAVE AN ACCOUNT?",
          style: TextStyle(
            color: Colors.black54,
            fontSize: 10,
          ),

        ),


      ),


    ]);
  }
}


