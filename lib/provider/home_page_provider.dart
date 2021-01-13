import 'package:flutter/cupertino.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
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
  bool _isInvoiceWidget = false;
  String _recurring = 'None';
  int _taxInclusiveDeductible = 0;
  List<InvoiceItemModel> _invoiceItem = [];
  Customer _invoiceCustomer;

  Widget get rideSideWidget => _rightSideScreen;
  List<String> get document => _documentList;
  bool get gstIncluded => _gstIncluded;
  bool get signature => _signatureValue;
  bool get clientSignature => _clientSignature;
  bool get secondTax => _secondTax;
  bool get isInvoiceWidget => _isInvoiceWidget;
  bool get removeDueDate => _removeDueDate;
  Customer get invoiceCustomer => _invoiceCustomer;
  String get recurring => _recurring;
  int get taxInclusiveDeductible => _taxInclusiveDeductible;
  List<InvoiceItemModel> get invoiceItem => _invoiceItem;

  set invoiceItem(List<InvoiceItemModel> list){
    _invoiceItem = list;
    notifyListeners();
  }
  set invoiceCustomer(Customer customer){
    _invoiceCustomer = customer;
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
  set isInvoiceWidget(bool newValue){
    _isInvoiceWidget = newValue;
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
  set addInvoiceItem(InvoiceItemModel item){
    _invoiceItem.add(item);
    notifyListeners();
  }
  set removeInvoiceItem(InvoiceItemModel item){
    _invoiceItem.remove(item);
    notifyListeners();
  }
  void updateInvoiceItem(InvoiceItemModel item,int index){
    _invoiceItem[index] = (item);
    notifyListeners();
  }
  set deleteDocument(String doc){
    if(doc != 'invoice'){
      _documentList.remove(doc);
      notifyListeners();
    }
  }
}