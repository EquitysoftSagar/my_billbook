import 'package:flutter/material.dart';
import 'package:my_billbook/page/login_page.dart';
import 'package:my_billbook/style/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: MyColors.primary,
          accentColor: MyColors.accent,
          scaffoldBackgroundColor: MyColors.screenBg      ),
      home: LoginPage(),
    );
  }
}