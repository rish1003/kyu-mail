import 'dart:convert';
//import 'package:studio_projects/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:googleapis/admin/directory_v1.dart';
import 'package:googleapis/gmail/v1.dart';
import 'package:http/http.dart' as http;
import 'package:kyu_mail/GmailSendScreen.dart';
import 'package:kyu_mail/controllers/MainController.dart';
import 'package:kyu_mail/reusables/text.dart';

//import 'package:studio_projects/reusable/drawerbutton.dart';
//import 'package:studio_projects/reusable/text.dart';
//import 'package:studio_projects/screens/openmail.dart';
//import 'package:studio_projects/screens/profilepage.dart';
//import '../reusable/textfield.dart';
//import 'sendingmail.dart';

class homepage extends StatefulWidget {
  const homepage({super.key, required this.photourl, required this.name, required this.email_list, required this.email,});
  final String photourl , name ,email;
  final Future<List<Message?>?> email_list ;
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {


  TextEditingController search = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      //backgroundColor: Color(0xFF1D1D1D),
      backgroundColor: Color(0xFF1D1D1D),
      drawer: Drawer(
        backgroundColor: Color(0xFF1D1D1D),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 100,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF595959),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          widget.photourl),
                      radius: 20.0,
                    ),
                    Text(widget.name),

                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.transparent,
                elevation: 0.0,

              ),
              child: Row(
                children: [
                  Icon(Icons.inbox_rounded, color: Colors.white),
                  SizedBox(width: 5,),
                  mytext(textip: "textip", fontsize: 18),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.transparent,
                elevation: 0.0,

              ),
              child: Row(
                children: [
                  Icon(Icons.send, color: Colors.white),
                  SizedBox(width: 5,),
                  mytext(textip: "sent", fontsize: 18),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },

              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.transparent,
                elevation: 0.0,

              ),
              child: Row(
                children: [
                  Icon(Icons.key, color: Colors.white),
                  SizedBox(width: 5,),
                  mytext(textip: "buy more keys", fontsize: 18),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {});
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              ),
              child: Row(
                children: [
                  Icon(Icons.logout_rounded, color: Colors.white),
                  SizedBox(width: 5,),
                  mytext(textip: "logout", fontsize: 18),
                ],
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          icon: Icon(Icons
              .format_list_bulleted_rounded), // Adjust icon based on filter functionality
          onPressed: () {
            //Scaffold.of(context).openDrawer();
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
        actions: [
          Container(
            width: 45,
          ),
          Expanded(
              child: TextField(
                style: TextStyle(
                    color: Color(0xFFD8D8D8), fontSize: 18.0), // Set the text color
                cursorColor: Color(0xFFD8D8D8),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.transparent,
                  hintText: 'Search', // Set the hint text
                  hintStyle: TextStyle(
                    color: Color(0xFF595959),
                    fontSize: 18.0,
                  ),
                  border: InputBorder.none,
                ),
                controller: search,
                maxLines: null,
              )),
          ElevatedButton(
            onPressed: () {
             // Get.to(() => profilepage());
            },
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(), // Keep the circular shape
              backgroundColor: Color(0xFF595959), // Set button color
              side: BorderSide(
                color: Color(0xFF686868), // Set border color
                width: 1.0, // Set border width
              ),
            ),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  widget.photourl),
              radius: 20.0,
            ),
          ),
        ],
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child: Column(children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Column(
                children: [
                  FutureBuilder<List<Message?>?>(
                    future: widget.email_list,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return Center(
                          child: Text('No data available.'),
                        );
                      } else {
                        List<Message?>? elist = snapshot.data;

                        return Expanded(
                          child: ListView.builder(
                            itemCount:7,
                            itemBuilder: (context, index) {
                              Message? data = elist?[index];
                              var d=MainController.instance.emailDetail(data!.id.toString(),widget.email);
                              final fromHeader = data!.payload!.headers!
                                  .where((header) => header.name == "From")
                                  .firstOrNull;
                              String pp = fromHeader!.value.toString();
                             Future<String?> up = MainController.instance.profile_picture(pp.substring(pp.indexOf("<")+1,pp.indexOf(">")));
                             print("up here "+up.toString());

                              return Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.white,
                                            width:
                                            0.2), // Specify only bottom border
                                      ),
                                    ),
                                    child: SizedBox(
                                      height: 100,
                                      child: TextButton(
                                        onPressed: () {
                                         // Get.to(() => openmail(emailid: data.received_email));
                                        },
                                        child: Row(
                                          children: [
                                            //photu
                                            //spacer
                                            Container(
                                              width: 12,
                                            ),
                                            //info
                                            Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                                  0.75,
                                              child: Column(
                                                children: [
                                                  Container(
                                                    height: 10,
                                                  ),
                                                  //email
                                                  Align(
                                                      alignment:
                                                      Alignment.topLeft,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                        children: [
                                                          Text(
                                                            fromHeader!.value.toString().substring(0,fromHeader!.value.toString().indexOf("<")),
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Color(
                                                                  0xFFD8D8D8),
                                                            ),
                                                          ),
                                                          Text(
                                                            data!.internalDate.toString(),
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xFF595959),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                  //message
                                                  Align(
                                                      alignment:
                                                      Alignment.topLeft,
                                                      child: Text(
                                                        data!.snippet.toString().substring(0,60)+"...",
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                          Color(0xFF595959),
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ]),
        ),
        //compose mail
        Positioned(
          bottom: 25.0, // Adjust this value to position the button as needed
          right: 25.0, // Adjust this value to position the button as needed
          child: SizedBox(
            height: 70.0, // adjust height as needed
            width: 70.0,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => GmailSendScreen());
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(), // Keep the circular shape
                backgroundColor: Color(0xFF595959), // Set button color
                disabledForegroundColor: Colors.white.withOpacity(0.38),
                disabledBackgroundColor: Colors.white.withOpacity(0.12),
                foregroundColor: Colors.white, // Set icon color
                side: BorderSide(
                  // Add border around the entire button
                  color: Color(0xFF686868), // Set border color
                  width: 2.0, // Set border width
                ),
              ),
              child: Icon(Icons.edit, size: 25.0),
            ),
          ),
        ),
      ]),
    );
  }
}


