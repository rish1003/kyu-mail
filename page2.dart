import 'package:flutter/material.dart';




class hello extends StatelessWidget {
  const hello({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Qmail',
      theme: ThemeData(
          primarySwatch: Colors.grey,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          fontFamily: 'Fahkwang',
          useMaterial3: true,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: const Color(0xFF1D1D1D)),
      home: const myHello(),
    );
  }
}

class myHello extends StatelessWidget{
  const myHello({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        child: const Text('Welcome',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),),
      ),
    );
  }
}

