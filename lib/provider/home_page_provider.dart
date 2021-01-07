import 'package:flutter/cupertino.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';

class HomePageProvider with ChangeNotifier{

  Widget _rightSideScreen = InvoiceWidget();
  List<String> _documentList = ['Invoice'];

  Widget get rideSideWidget => _rightSideScreen;
  List<String> get document => _documentList;

  set rideSideWidget(Widget newWidget){
    _rightSideScreen = newWidget;
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