import 'dart:convert';
import 'package:studio_projects/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:studio_projects/screens/openmail.dart';
import '../reusable/textfield.dart';
import 'sendingmail.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
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
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D1D1D),
      appBar:
      AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: Icon(Icons.format_list_bulleted_rounded), // Adjust icon based on filter functionality
            onPressed: () {
              // Implement filter functionality
            },
          ),
          Expanded(
              child: TextField(
                style: TextStyle(
                    color: Color(0xFFD8D8D8),
                    fontSize: 18.0), // Set the text color
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
              )
          ),
          ElevatedButton(
            onPressed: () {
              Get.to(() => sendingmail());
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
                  "https://www.hartz.com/wp-content/uploads/2022/04/small-dog-owners-1.jpg"),
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
                  FutureBuilder<List<watch>>(
                    future: getWatchlistData(),
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
                        List<watch>? wllist = snapshot.data;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: wllist?.length,
                            itemBuilder: (context, index) {
                              watch? data = wllist?[index];
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
                                          Get.to(() => openmail(emailid: data.received_email));
                                        },
                                        child: Row(
                                          children: [
                                            //photu
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  data!.profile_image),
                                              radius: 30.0,
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
                                                            data.received_email,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              color: Color(
                                                                  0xFFD8D8D8),
                                                            ),
                                                          ),
                                                          Text(
                                                            data.time_arrived,
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
                                                        data.message.substring(
                                                                0, 60) +
                                                            "...",
                                                        style: TextStyle(
                                                          fontSize: 18,
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
                Get.to(() => sendingmail());
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

class watch {
  String profile_image, received_email, message, time_arrived;

  watch({
    required this.profile_image,
    required this.received_email,
    required this.message,
    required this.time_arrived,
  });
}
