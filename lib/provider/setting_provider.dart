import 'package:flutter/cupertino.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';

class SettingProvider with ChangeNotifier{

  String _dueInDays = '7';
  String _dateFormat = '05 Apr 2014';
  String _language = 'English';

  get dueInDays => _dueInDays;
  get dateFormat => _dateFormat;
  get language => _language;

  set dueInDays(String newValue){
    _dueInDays = newValue;
    notifyListeners();
  }
  set dateFormat(String newValue){
    _dateFormat = newValue;
    notifyListeners();
  }
  set language(String newValue){
    _language = newValue;
    notifyListeners();
  }
}