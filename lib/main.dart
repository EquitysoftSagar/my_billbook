import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/model/user.dart';
import 'package:my_billbook/page/home_page.dart';
import 'package:my_billbook/page/login_page.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/routes.dart';
import 'package:my_billbook/util/size_config.dart';
import 'package:provider/provider.dart';

import 'provider/invoice_number_provider.dart';
import 'provider/setting_provider.dart';

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
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (BuildContext context) => HomePageProvider(),),
            ChangeNotifierProvider(create: (BuildContext context) => SettingProvider(),),
            ChangeNotifierProvider(create: (BuildContext context) => InvoiceNumberProvider(),),
          ],
          child: MaterialApp(
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
            onGenerateRoute: (settings){
              switch(settings.name){
                case Routes.login :
                  return MaterialPageRoute(builder: (context) => LoginPage());
                case Routes.home :
                  return MaterialPageRoute(builder: (context) => HomePage());
                default :
                  return MaterialPageRoute(builder: (context) => LoginPage());
              }
            },
            home: FirebaseAuth.instance.currentUser == null ? LoginPage() : HomePage()
          ),
        );
      },
    );
  }
}