import 'package:flutter/material.dart';

import 'package:paintme/screens/today.dart';

void main() {
  runApp(
    PaintmeApp(),
  );
}

class PaintmeApp extends StatelessWidget {
  const PaintmeApp({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF0EDE4),
        fontFamily: 'NotoSansKR',
        textTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
          headline2: TextStyle(
              fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
          headline3: TextStyle(
              fontSize: 47, fontWeight: FontWeight.normal, letterSpacing: 0),
          headline4: TextStyle(
              fontSize: 33, fontWeight: FontWeight.normal, letterSpacing: 0.25),
          headline5: TextStyle(
              fontSize: 23, fontWeight: FontWeight.normal, letterSpacing: 0),
          headline6: TextStyle(
              fontSize: 19, fontWeight: FontWeight.w700, letterSpacing: 0.15),
          subtitle1: TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.15),
          subtitle2: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 0.1),
          bodyText1: TextStyle(
              fontSize: 16, fontWeight: FontWeight.normal, letterSpacing: 0.5),
          bodyText2: TextStyle(
              fontSize: 14, fontWeight: FontWeight.normal, letterSpacing: 0.25),
          button: TextStyle(
              fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 1.25),
          caption: TextStyle(
              fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.4),
          overline: TextStyle(
              fontSize: 10, fontWeight: FontWeight.normal, letterSpacing: 1.5),
        ),
      ),
      title: 'FriendlyChat',
      home: TodayScreen(),
    );
  }
}
