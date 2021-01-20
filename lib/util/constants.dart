import 'package:my_billbook/model/user.dart';

class Constants{

  //reg exp
  static RegExp emailRegExp = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

  //Collection

//token
static String userDocId = '';
static String indianCurrencySymbol = '₹';
}
UserModel userModel = UserModel();
