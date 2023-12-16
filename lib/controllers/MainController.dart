import 'dart:convert';

import 'package:get/Get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:kyu_mail/home.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis/gmail/v1.dart' as gmail;
import 'package:kyu_mail/googleauth.dart';

class MainController extends GetxController{
  static MainController get instance => Get.find();
  var verificationid = ''.obs;
  GoogleSignInAccount? user;
  Future G_Sign_in()async{
     user = await GoogleAuthApi.sign_in();
    if (user == null){
      print("user null");
      return ;
    }
    else{
      final  email = user?.email;
      final auth = await user?.authentication;
      final Token = auth?.accessToken;
      Future<List<gmail.Message?>?> e =  emailList(user!.email, Token!);
      if (e != null){
        print("Hererererererer");
        Get.to(homepage(photourl:user!.photoUrl.toString(), name:user!.displayName.toString(), email_list: e, email:email.toString(), ));

      }
    }
  }
  Future send_email(List Recipients,List cc, List bcc,String Subjects ,String text ,List<Attachment>Attachments  )async{
    if (user == null){
      print("user null");
      return ;
    }
    final  email = user?.email;
    final auth = await user?.authentication;
    final Token = auth?.accessToken;
    final smtpServer= gmailSaslXoauth2(email!, Token!);
    final message = Message()
      ..from = Address(email,user?.displayName)
      ..recipients= Recipients
      ..ccRecipients=cc
      ..bccRecipients=bcc
      ..subject=Subjects
      ..text=text;
    print(""+Recipients.toString()+""+cc.toString()+""+bcc.toString()+Subjects+text);
    //email_list(email, Token);
    try{
      await send(message, smtpServer);

    }on MailerException catch(e){
      print("jai mata di please workk");
      print(e);
      print(e.reactive);
    }

  }
  Future<List<gmail.Message?>?> emailList(String userId, String accessToken) async {
    print("user is here $userId $accessToken");
    var request = http.Request('GET', Uri.parse("https://gmail.googleapis.com/gmail/v1/users/$userId/messages?"));
    final headers = {
      "Authorization": "Bearer $accessToken",
    };
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var dat = await response.stream.bytesToString();
      var resp = jsonDecode(dat);
      print(resp);

      List<Future<gmail.Message?>> messageFutures = [];
      for (int i = 0; i <=50; i++) {
        print("bhai idhar dekh le"+i.toString());
        final messageFuture = emailDetail(userId, resp['messages'][i]['id']);
        print(messageFuture);
        messageFutures.add(messageFuture);
      }

      List<gmail.Message?>? messages = await Future.wait(messageFutures);

      return messages;
    } else {
      //throw Exception("Error searching emails: ${response.statusCode}");
    }
  }

  Future<gmail.Message?> emailDetail(String userId, String id) async {
    final auth = await user?.authentication;
    final Token = auth?.accessToken;
    final url = "https://gmail.googleapis.com/gmail/v1/users/$userId/messages/$id";
    final headers = {
      "Authorization": "Bearer $Token",
      "maxResults": "20",
    };
    final response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      final data = gmail.Message.fromJson(jsonDecode(response.body));
      return data;
    } else {
     // throw Exception("Error searching emails: ${response.reasonPhrase}");
    }
  }
  Future<String?> profile_picture (uid) async {
    var request = http.Request('GET', Uri.parse('https://admin.googleapis.com/admin/directory/v1/users/{$uid}/photos/thumbnail'));


    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var dat =await response.stream.bytesToString();
      var resp= jsonDecode(dat);
      final pic = UserPhoto.fromJson(jsonDecode(resp));
      print(pic.mimeType);
      return pic.photoData.toString() ;
    }
    else {
    print(response.reasonPhrase);
    }

  }


}