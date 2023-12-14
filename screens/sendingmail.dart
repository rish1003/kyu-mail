import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studio_projects/reusable/customtextfield.dart';
import 'package:studio_projects/reusable/textfield.dart';

import 'package:file_picker/file_picker.dart';
import 'package:open_file/open_file.dart';
import '../reusable/text.dart';

class sendingmail extends StatefulWidget {
  sendingmail({Key? key});

  @override
  State<sendingmail> createState() => _sendingmailState();
}

class _sendingmailState extends State<sendingmail> {
  String selectedFileName = '';

  TextEditingController from = TextEditingController();

  TextEditingController to = TextEditingController();

  TextEditingController message = TextEditingController();


  TextEditingController cc = TextEditingController();

  TextEditingController bcc = TextEditingController();

  TextEditingController subject = TextEditingController();
  TextEditingController enc = TextEditingController();

  bool isFieldsVisible = false;
  bool isEncFieldsVisible = false;

  List<String> emails = [];

  List<String> ccemails = [];

  List<String> bccemails = [];
  PlatformFile file = PlatformFile( name: '', size: 0);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D1D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Transform.rotate(
            angle: 90 * (3.141592653589793 / 180),
            child: IconButton(
              icon: Icon(Icons.attach_file),
              onPressed: () async {
                final result = await FilePicker.platform.pickFiles(allowMultiple: false);
                if (result == null) return;
                file = result.files.first;
                setState(() {
                  selectedFileName = file.name ?? 'No file selected';
                });
              },
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {},
            color: Colors.white,
          ),
        ],
        centerTitle: true,
        title: Ink(
          decoration: ShapeDecoration(
            color: Colors.grey[900],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50.0),
              side: BorderSide(
                color: Colors.white,
                width: 0.5,
              ),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              minimumSize: Size(100, 25), // Adjust the minimum size to 85x30
            ),
            child: Container(
              width: 85,
              height: 25, // Adjust the height to 30
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.vpn_key,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8.0),
                  mytext(
                    textip: '62',
                    fontsize: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0), // Set the desired border height
          child: Container(
            height: 0.4,
            color: Colors.white, // Set the color of the border
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              //from
              Row(
                children: [
                  Container(
                      width: 55,
                      child: Text(
                        "From:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFFFFFF),
                        ),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width - 105,
                    child: textfield(controller: from),
                  )
                ],
              ),
              //to
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 35,
                          child: Text(
                            "To:",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width - 103,
                        child: CustomTextField(
                          controller: to,
                          list1: emails,
                        ),
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                isFieldsVisible = !isFieldsVisible;
                              },
                            );
                          })
                    ],
                  ),
                  Visibility(
                    visible: isFieldsVisible,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                                width: 35,
                                child: Text(
                                  "CC:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width - 65,
                              child: CustomTextField(
                                controller: cc,
                                list1: ccemails,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                                width: 45,
                                child: Text(
                                  "BCC:",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFFFFFFFF),
                                  ),
                                )),
                            Container(
                              width: MediaQuery.of(context).size.width - 65,
                              child: CustomTextField(
                                controller: bcc,
                                list1: bccemails,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //Subject
              Row(
                children: [
                  Container(
                      width: 75,
                      child: Text(
                        "Subject:",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFFFFFFFF),
                        ),
                      )),
                  Container(
                    width: MediaQuery.of(context).size.width - 105,
                    child: textfield(
                      controller: subject,
                    ),
                  ),
                ],
              ),
              //encryption
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 100,
                          child: Text(
                            "Encryption:",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          )),
                      Container(
                        width: MediaQuery.of(context).size.width - 168,
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
                          controller: enc,
                        ),),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(
                              () {
                                isEncFieldsVisible = !isEncFieldsVisible;
                              },
                            );
                          })
                    ],
                  ),
                  Visibility(
                    visible: isEncFieldsVisible,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            onPressed: () {
                              enc.text = "LEVEL1";
                              setState(() {
                                isEncFieldsVisible = !isEncFieldsVisible;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft, // Set alignment to left
                              child: Text(
                                "LEVEL1",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color(0xFFD8D8D8),
                                  decoration: TextDecoration.underline, // Set text underline
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),

                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                enc.text="LEVEL2";
                                setState(() {
                                  isEncFieldsVisible = !isEncFieldsVisible;
                                },);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent, // Set button background color to transparent
                                elevation: 0, // Set button elevation to 0
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft, // Set alignment to left
                                child: Text(
                                  "LEVEL2",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFD8D8D8),
                                    decoration: TextDecoration.underline, // Set text underline
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () {
                                enc.text="LEVEL3";
                                setState(() {
                                  isEncFieldsVisible = !isEncFieldsVisible;
                                },);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent, // Set button background color to transparent
                                elevation: 0, // Set button elevation to 0
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft, // Set alignment to left
                                child: Text(
                                  "LEVEL3",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFD8D8D8),
                                    decoration: TextDecoration.underline, // Set text underline
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              //message
              Column(
                children: [
                  Container(
                    width:  MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        TextField(
                          style: TextStyle(
                            color: Color(0xFFD8D8D8),
                            fontSize: 18.0,
                          ),
                          cursorColor: Color(0xFFD8D8D8),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            hintText: 'Compose a mail', // Set the hint text
                            hintStyle: TextStyle(
                              color: Color(0xFF595959),
                              fontSize: 18.0,
                            ),
                            border: InputBorder.none,
                          ),
                          controller: message,
                          maxLines: null,
                        ),

                      ],
                    ),
                  )
                ],
              ),
              //attachment
              Column(
                children: [
                  if (file.name != "")
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            openfile(file);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF595959), // Background color of the button
                          ),
                          child: Text(
                            selectedFileName,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    }

  void openfile(PlatformFile file) {
    print(file.path.toString());
    OpenFile.open(file.path!);
  }
  }


