

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:qmail/home2.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});
  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String? varifyCode;
  //var signupconrol = Get.put(signupcontrol());
  var otp;
  String ph = "";
  final TextEditingController phController = TextEditingController();
  final TextEditingController _pinPutController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(

          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: Image.asset(
                  "assets/loginp2.png",
                  width: 428,
                  height: 400,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: Color(0xFF755DC1),
                        fontSize: 27,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height:20,
                    ),
                    TextField(

                      autofocus: true,
                      controller: phController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      scrollPadding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                      style: const TextStyle(
                        color: Color(0xFF393939),
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF837E93),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            width: 1,
                            color: Color(0xFF9F7BFF),
                          ),
                        ),
                      ),
                    ),
                    Pinput(
                      length: 6,
                      controller: _pinPutController,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      onCompleted: (String pin) async{
                        otp = pin;
                      },
                    ),
                    const SizedBox(
                        height: 20
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          ph = "+91${phController.text.trim()}";
                        //  signupcontrol.instance.verifyPhone(ph);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9F7BFF),
                            fixedSize: const Size(150,20)
                        ),
                        child: const Text(
                          'Send OTP',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),),
                    Center(

                      child: ElevatedButton(
                        onPressed: () {
                         // signupcontrol.instance.verifyOTP(_pinPutController.text,ph);
                        },

                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9F7BFF),
                            fixedSize: const Size(150,20)
                        ),
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an account?',
                          style: TextStyle(
                            color: Color(0xFF837E93),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          width: 2.5,
                        ),
                        InkWell(
                          onTap: ()  {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  home2())//SignInPage()),
                            );
                          },
                          child:  const Text(
                            'Log In',
                            style: TextStyle(
                              color: Color(0xFF755DC1),
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                            ),

                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )

            ],
          ),
        )
    );
  }
}