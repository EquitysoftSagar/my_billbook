import 'package:flutter/cupertino.dart';
import 'package:my_billbook/model/bills.dart';

class InvoiceNumberProvider with ChangeNotifier{

  List<Bills> _billsList = [];

  List<Bills> get billsList => _billsList;

  set billsList (List<Bills> newList){
    _billsList = newList;
    notifyListeners();
  }
}