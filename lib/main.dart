import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/page/home_page.dart';
import 'package:my_billbook/page/login_page.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/size_config.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        SizeConfig.init(constraints);
        FirebaseService.init();
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: MyColors.primary,
            accentColor: MyColors.accent,
            scaffoldBackgroundColor: MyColors.screenBg,
            buttonColor: MyColors.button,
            appBarTheme: AppBarTheme(
              color: MyColors.accent,
              textTheme: TextTheme(
                title: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                    fontSize: 20)
              ),
            )
          ),
          home:LoginPage(),
        );
      },
    );
  }
}