import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:studio_projects/reusable/text.dart';
import 'package:studio_projects/screens/forwardingmail.dart';
import 'package:studio_projects/screens/replyingmail.dart';

import '../reusable/textfield.dart';

class openmail extends StatefulWidget {
   openmail({super.key});

  @override
  State<openmail> createState() => _openmailState();
}

class _openmailState extends State<openmail> {
  TextEditingController subject = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D1D),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [],
      ),
      body: Stack(
        children: [SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      //subject
                      Row(
                        children: [
                          Container(
                              width: 75,
                              child: Text(
                                "Subject:",
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Color(0xFFFFFFFF),
                                ),
                              )),
                          Container(
                            width: MediaQuery.of(context).size.width - 105,
                            child: TextField(
                              style: TextStyle(
                                  color: Color(0xFFD8D8D8),
                                  fontSize: 18.0), // Set the text color
                              cursorColor: Color(0xFFD8D8D8),
                              readOnly: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors
                                    .transparent, // Set the background color to transparent
                                border: InputBorder.none,
                              ),
                              controller: subject,
                              maxLines: null,
                            ),
                          ),
                        ],
                      ),
                      Container(height: 8,),
                      Container(
                        height: 0.2,
                        width: double.infinity,
                        color: Colors.white,
                      ),
                      Container(height: 8,),

                      Row(
                        children: [
                          //photu
                          //CircleAvatar(backgroundImage: NetworkImage(data!.profile_image), radius: 30.0,),
                          CircleAvatar(backgroundImage: NetworkImage("https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/RedCat_8727.jpg/1200px-RedCat_8727.jpg"), radius: 30.0,),
                          //spacer
                          Container(
                            width: 12,
                          ),
                          //info
                          Container(
                            width: MediaQuery.of(context).size.width*0.75,
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
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          //data.received_email,
                                          "email@qmail.com",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color:
                                            Color(0xFFD8D8D8),
                                          ),
                                        ),
                                      ],
                                    )),
                                //message
                                Align(
                                    alignment:
                                    Alignment.topLeft,
                                    child: Text(
                                      //data.time_arrived,
                                      "11:11",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color:
                                        Color(0xFF595959),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(height: 8,),
                      Container(height: MediaQuery.of(context).size.height*0.7, width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(children: [
                            Row(
                              children: [ mytext(textip: "message", fontsize: 18)],
                            ),
                            Row(
                              children: [ mytext(textip: "attachments figure karna hai", fontsize: 18)],
                            )
                          ],),
                        ),)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
          //reply
          Positioned(
            bottom: 25.0, // Adjust this value to position the button as needed
            left: 25.0, // Adjust this value to position the button as needed
            child: SizedBox(
              height: 55.0, // adjust height as needed
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => replymail());
                },
                style: ElevatedButton.styleFrom(
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
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_rounded, size: 25.0),
                    Container(width: 8,),
                    mytext(textip: "Reply", fontsize: 22),
                  ],
                ),
              ),
            ),
          ),
          //forward
          Positioned(
            bottom: 25.0, // Adjust this value to position the button as needed
            right: 25.0, // Adjust this value to position the button as needed
            child: SizedBox(
              height: 55.0, // adjust height as needed
              width: 150.0,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => forwardingmail());
                },
                style: ElevatedButton.styleFrom(
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
                child: Row(
                  children: [
                    Icon(Icons.arrow_forward_rounded, size: 25.0),
                    mytext(textip: "Froward", fontsize: 22),
                  ],
                ),
              ),
            ),
          ),]

      ),
    );
  }
}
