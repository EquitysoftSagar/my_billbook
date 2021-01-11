import 'package:flutter/cupertino.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';

class HomePageProvider with ChangeNotifier{

  Widget _rightSideScreen = InvoiceWidget();
  List<String> _documentList = ['Invoice'];
  bool _gstIncluded = true;
  bool _signatureValue = false;
  bool _clientSignature = false;
  bool _secondTax = false;
  String _recurring = 'None';
  int _taxInclusiveDeductible = 0;
  List<Item> _invoiceItem = [];

  Widget get rideSideWidget => _rightSideScreen;
  List<String> get document => _documentList;
  bool get gstIncluded => _gstIncluded;
  bool get signature => _signatureValue;
  bool get clientSignature => _clientSignature;
  bool get secondTax => _secondTax;
  String get recurring => _recurring;
  int get taxInclusiveDeductible => _taxInclusiveDeductible;
  List<Item> get invoiceItem => _invoiceItem;

  set rideSideWidget(Widget newWidget){
    _rightSideScreen = newWidget;
    notifyListeners();
  }
  set invoiceItem(List<Item> newValue){
    _invoiceItem = newValue;
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
  set signature(bool newValue){
    _signatureValue = newValue;
    notifyListeners();
  }
  set clientSignature(bool newValue){
    _clientSignature = newValue;
    notifyListeners();
  }
  set recurring(String newValue){
    _recurring = newValue;
    notifyListeners();
  }
  set addDocument(String doc){
    _documentList.add(doc);
    notifyListeners();
  }
  set deleteDocument(String doc){
    if(doc != 'invoice'){
      _documentList.remove(doc);
      notifyListeners();
    }
  }
}