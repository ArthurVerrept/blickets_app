import 'package:flutter/material.dart';
import 'splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      title: 'appName',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: const Color(0xffFCFCFC),
        progressIndicatorTheme:
            ProgressIndicatorThemeData(color: Color(0xffE43C4A)),
        // Define the default brightness and colors.
        // brightness: Brightness.dark,r
        primaryColor: const Color(0xffFCFCFC),
        iconTheme: const IconThemeData(
          size: 30,
          color: Color(0xff111827),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Color(0xffFCFCFC),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          color: Color(0xffFCFCFC),
          elevation: 0,
          iconTheme: IconThemeData(
            size: 30,
            color: Color(0xff323232),
          ),
          titleTextStyle: TextStyle(
            fontFamily: 'Shrikhand',
            fontSize: 22,
            color: Color(0xffE43C4A),
          ),
        ),

        // Define the default font family.
        fontFamily: 'Georgia',

        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
    );
  }
}
