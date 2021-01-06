import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/page/login_page.dart';
import 'package:my_billbook/style/colors.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: MyColors.primary,
          accentColor: MyColors.accent,
          scaffoldBackgroundColor: MyColors.screenBg,
        buttonColor: MyColors.button,
      ),
      home: LoginPage(),
    );
  }
}