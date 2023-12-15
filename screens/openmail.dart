import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:studio_projects/global.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:studio_projects/reusable/text.dart';
import 'package:studio_projects/screens/forwardingmail.dart';
import 'package:studio_projects/screens/replyingmail.dart';

import '../reusable/textfield.dart';

class openmail extends StatefulWidget {
  String emailid;
  openmail({super.key, required this.emailid});

  @override
  State<openmail> createState() => _openmailState();
}

class _openmailState extends State<openmail> {
  TextEditingController subject = TextEditingController();
  TextEditingController message = TextEditingController();
  bool isFieldsVisible = false;


  Future<List<watch>> getWatchlistData() async {
    List<watch> wllist = [];

    var request = http.Request(
        'GET', Uri.parse(global.url + '/watchlistview/9987842719'));

    http.StreamedResponse response = await request.send();
    var data = await response.stream.bytesToString();
    print(data);
    if (response.statusCode == 200) {
      var a = jsonDecode(data.toString());
      for (Map i in a) {
        watch wt = watch(
          profile_image:
              'https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/RedCat_8727.jpg/1200px-RedCat_8727.jpg',
          received_email: 'emailid@qmail.com',
          message:
              'Lorem ipsum dolor sit amet, elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
          time_arrived: "11:11",
        );

        wllist.add(wt);
      }
      return wllist;
    } else {
      print(response.reasonPhrase);
    }
    return wllist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D1D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [],
      ),
      body: Stack(children: [
        Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*0.89,
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
                        //subject
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
                    Container(
                      height: 8,
                    ),
                    //whiteline
                    Container(
                      height: 0.2,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    Container(
                      height: 8,
                    ),
                    //message info
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width-16,
                                child: TextField(
                                  style: TextStyle(
                                      color: Color(0xFFD8D8D8),
                                      fontSize: 16.0), // Set the text color
                                  cursorColor: Color(0xFFD8D8D8),
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors
                                        .transparent, // Set the background color to transparent
                                    border: InputBorder.none,
                                  ),
                                  controller: message,
                                  maxLines: null,
                                ),
                              ),],
                          ),
                          Row(
                            children: [
                              mytext(
                                  textip: "attachments figure karna hai",
                                  fontsize: 18),
                              ElevatedButton(
                                onPressed: () {
                                  //Get.to(() => openFile(fileUrl));
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
                            ],
                          )
                        ],
                      ),
                    ),
                    FutureBuilder<List<watch>>(
                      future: getWatchlistData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          List<watch>? wllist = snapshot.data;
                          return Expanded(
                            child: ListView.builder(
                              itemCount: wllist?.length,
                              itemBuilder: (context, index) {
                                watch? data = wllist?[index];
                                return Column(
                                  children: [
                                    Container(height: 12,),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          top: BorderSide(
                                              color: Colors.white,
                                              width: 0.2),),),
                                      height:75,
                                      child: TextButton(
                                        onPressed: () {
                                          //Get.to(() => replymail());
                                          isFieldsVisible = !isFieldsVisible;
                                          setState(() {
                                          });
                                        },
                                        child: Row(
                                          children: [
                                            //photu
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  data!.profile_image),
                                              radius: 25.0,
                                            ),
                                            //spacer
                                            Container(
                                              width: 12,
                                            ),
                                            //info
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              child: Column(
                                                children: [

                                                  //email reusable?
                                                  Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            data.received_email,
                                                            style:
                                                                TextStyle(
                                                              fontSize: 18,
                                                              color: Color(
                                                                  0xFFD8D8D8),
                                                            ),
                                                          ),
                                                        ],
                                                      )),

                                                  Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            data.time_arrived,
                                                            style:
                                                                TextStyle(
                                                              fontSize: 15,
                                                              color: Color(
                                                                  0xFF595959),
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                  Align(
                                                      alignment:
                                                          Alignment.topLeft,
                                                      child: Visibility(
                                                        visible: !isFieldsVisible,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              data.message
                                                                      .substring(
                                                                          0,
                                                                          40) +
                                                                  "...",
                                                              style:
                                                                  TextStyle(
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xFF595959),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Visibility(
                                      visible: isFieldsVisible,
                                      child: Container(
                                        child: Text(
                                          data.message,
                                          style:
                                          TextStyle(
                                            fontSize: 15,
                                            color: Color(
                                                0xFF595959),
                                          ),
                                          maxLines: null,
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
                    ),
                    Container(height: 85,
                      color: Colors.black,),
                  ],
                ),
              ),
            )
          ],
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
                  Container(
                    width: 8,
                  ),
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
        ),
      ]),
    );
  }
  //Future<void> openFile(String fileUrl) async {await FilePicker.platform.openFile(path: fileUrl);}
}

class watch {
  String profile_image, received_email, message, time_arrived;

  watch({
    required this.profile_image,
    required this.received_email,
    required this.message,
    required this.time_arrived,
  });
}
