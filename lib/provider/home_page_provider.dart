import 'package:flutter/cupertino.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';

class HomePageProvider with ChangeNotifier{

  Widget _rightSideScreen = InvoiceWidget();
  List<String> _documentList = ['Invoice'];
  bool _gstIncluded = true;
  bool _signatureValue = false;
  bool _clientSignature = false;
  bool _secondTax = false;
  bool _removeDueDate = false;
  String _recurring = 'None';
  int _taxInclusiveDeductible = 0;
  List<Item> _invoiceItem = [];
  List<Customer> _invoiceCustomer = [];

  Widget get rideSideWidget => _rightSideScreen;
  List<String> get document => _documentList;
  bool get gstIncluded => _gstIncluded;
  bool get signature => _signatureValue;
  bool get clientSignature => _clientSignature;
  bool get secondTax => _secondTax;
  bool get removeDueDate => _removeDueDate;
  String get recurring => _recurring;
  int get taxInclusiveDeductible => _taxInclusiveDeductible;
  List<Item> get invoiceItem => _invoiceItem;
  List<Customer> get invoiceCustomer => _invoiceCustomer;

  set invoiceItem(List<Item> list){
    _invoiceItem = list;
    notifyListeners();
  }
  set invoiceCustomer(List<Customer> list){
    _invoiceCustomer = list;
    notifyListeners();
  }
  set rideSideWidget(Widget newWidget){
    _rightSideScreen = newWidget;
    notifyListeners();
  }
  set gstIncluded(bool newValue){
    _gstIncluded = newValue;
    notifyListeners();
  }
  set removeDueDate(bool newValue){
    _removeDueDate = newValue;
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
  set addInvoiceItem(Item item){
    _invoiceItem.add(item);
    notifyListeners();
  }
  set removeInvoiceItem(Item item){
    _invoiceItem.remove(item);
    notifyListeners();
  }
  set addInvoiceCustomer(Customer customer){
    _invoiceCustomer.add(customer);
    notifyListeners();
  }
  set removeInvoiceCustomer(Customer customer){
    _invoiceCustomer.remove(customer);
    notifyListeners();
  }
  set deleteDocument(String doc){
    if(doc != 'invoice'){
      _documentList.remove(doc);
      notifyListeners();
    }
  }
}