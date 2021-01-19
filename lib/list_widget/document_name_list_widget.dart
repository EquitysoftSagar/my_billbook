import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/document_item_view_widget.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/provider/invoice_number_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class DocumentNameListWidget extends StatelessWidget {

  String _firstId;
  Bills _firstBills;
  bool _isLoaded = false;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: FirebaseService.getBills(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
        if(snap.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }else if(snap.data.docs.length == 0){
          return Text(
            'No Document',
            style: TextStyle(
                color: MyColors.invoiceTxt,
                fontWeight: FontWeight.w600,
                fontSize: 20.0),
          );
        }else{
          if(!_isLoaded){
            _firstId = snap.data.docs[0].id;
            _firstBills = Bills.fromJson(snap.data.docs[0].data());
            _isLoaded = true;
            setInvoiceScreen(context);
          }
          setInvoiceSettings(context,snap.data.docs);
          return ListView.builder(itemBuilder: (BuildContext context, int index) {
            return DocumentItemViewWidget(
              index: index,
              id: snap.data.docs[index].id,
              bills: Bills.fromJson(snap.data.docs[index].data()),
              onTap: (String id,Bills bills){
                onDocumentTap(context,id,bills);
              },
            );
          },
            itemCount: snap.data.docs.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          );
        }
      },
    );
  }
  void setInvoiceSettings(BuildContext context,List<QueryDocumentSnapshot> list){
    WidgetsBinding.instance.addPostFrameCallback((_){
      var _provider = Provider.of<InvoiceNumberProvider>(context,listen: false);

      var _billsList = List.generate(list.length, (index) {
        var bills = Bills.fromJson(list[index].data());
        bills.id = list[index].id;
        return bills;
      });
      _provider.billsList = _billsList;
    });
  }

  void setInvoiceScreen(BuildContext context){
    WidgetsBinding.instance.addPostFrameCallback((_){
      Provider.of<HomePageProvider>(context,listen: false).rideSideWidget = InvoiceWidget(
          id: _firstId,
          bills: _firstBills
      );
    });
  }
  void onDocumentTap(BuildContext context, String id, Bills bills) {
    final _provider = Provider.of<HomePageProvider>(context,listen: false);
    _provider.rideSideWidget = InvoiceWidget(
      id: id,
      bills: bills,
    );
  }
}
