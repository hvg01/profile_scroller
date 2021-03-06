import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:hodomojo_assn/homepage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HodoMojo',
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
      ),
      home: Homepage(),
    );
  }
}

