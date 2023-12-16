import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthApi {
  static final  g =GoogleSignIn(scopes: ['https://mail.google.com/'],clientId: "1025475050051-jeeh7na3coge7fpms6ihvf24do7elki4.apps.googleusercontent.com");
  static Future< GoogleSignInAccount?>sign_in()async{
    if(await g.isSignedIn()==true){
      print("hey here");
      return g.currentUser;
    }
    print("heyy heree 2");
    return await g.signIn();

  }
  static Future< GoogleSignInAccount?>sign_out()async{

    print("heyy heree 2");
    return await g.signOut();

  }
}