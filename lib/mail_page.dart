import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/Get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kyu_mail/controllers/MainController.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'googleauth.dart';

class mail_page extends StatefulWidget{

  const mail_page({super.key});
  @override
  State<mail_page> createState() => _mail_pageState();
}

class _mail_pageState extends State<mail_page> {
  var Main_controller=Get.put(MainController());
  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:ElevatedButton(
              child:Text("Send email "),
              onPressed:(){
                MainController.instance.G_Sign_in();
              },
            ),
          ),


    ElevatedButton(
    onPressed: () async {
    await GoogleAuthApi.sign_out();
    // Navigate to login page, show success message, etc.
    },
    child: Text("Sign Out"),
    ),
        ],
      ),
    );

  }

}

