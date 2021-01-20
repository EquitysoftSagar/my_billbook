import 'package:flutter/cupertino.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';

class HomePageProvider with ChangeNotifier{

  Widget _rightSideScreen = Container();
  bool _gstIncluded = true;
  bool _secondTax = false;
  int _taxInclusiveDeductible = 0;
  bool _isInvoiceWidget = false;
  bool _billsLoaded = false;

  Widget get rideSideWidget => _rightSideScreen;
  bool get gstIncluded => _gstIncluded;
  bool get secondTax => _secondTax;
  bool get isInvoiceWidget => _isInvoiceWidget;
  bool get billsLoaded => _billsLoaded;
  int get taxInclusiveDeductible => _taxInclusiveDeductible;

  set billsLoaded(bool newValue){
    _billsLoaded = newValue;
    notifyListeners();
  }

  set rideSideWidget(Widget newWidget){
    _rightSideScreen = newWidget;
    notifyListeners();
  }
  set isInvoiceWidget(bool newValue){
    _isInvoiceWidget = newValue;
    notifyListeners();
  }
  set gstIncluded(bool newValue){
    _gstIncluded = newValue;
    notifyListeners();
  }

  set secondTax(bool newValue){
    _secondTax = newValue;
    notifyListeners();
  }
  set taxInclusiveDeductible(int newValue){
    _taxInclusiveDeductible = newValue;
    notifyListeners();
  }

}