import 'package:flutter/material.dart';
import 'home.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      home: const MyHomePage(),
    );
  }
}

