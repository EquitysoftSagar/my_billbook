import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/alert_dialog.dart';
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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseService.getBills(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
        if(snap.hasData){
          var _length = snap.data.docs.length;
          setInvoiceSettings(context,snap.data.docs);
          setInvoiceScreen(context,snap.data.docs[0].data(),snap.data.docs[0].id);
          return ListView.builder(itemBuilder: (BuildContext context, int index) {
            return DocumentItemViewWidget(
              index: index,
              lenght: _length,
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
        }else{
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  void setInvoiceSettings(BuildContext context,List<QueryDocumentSnapshot> list){
    WidgetsBinding.instance.addPostFrameCallback((_){
      final _provider = Provider.of<InvoiceNumberProvider>(context,listen: false);
      var _billsList = List.generate(list.length, (index) {
        var bills = Bills.fromJson(list[index].data());
        bills.id = list[index].id;
        return bills;
      });
      _provider.billsList = _billsList;
    });
  }

  void setInvoiceScreen(BuildContext context,Map data,String id){
    WidgetsBinding.instance.addPostFrameCallback((_){
      final _homeProvider = Provider.of<HomePageProvider>(context,listen: false);
      if(!_homeProvider.billsLoaded) {
        _homeProvider.rideSideWidget = InvoiceWidget(
            id: id,
            bills: Bills.fromJson(data)
        );
        _homeProvider.billsLoaded = true;
      }
    });
  }
  void onDocumentTap(BuildContext context, String id, Bills bills) {
    final _provider = Provider.of<HomePageProvider>(context,listen: false);
    if(_provider.isInvoiceWidget){
      showDialog(
          context: context,
          builder: (context) =>
              MyAlertDialog(
                  title:
                  'Are you sure you want to leave without saving?',
                  onYesTap: (){
                    _provider.isInvoiceWidget = false;
                    _provider.rideSideWidget = InvoiceWidget(
                      id: id,
                      bills: bills,
                    );
                  }
              ));
    }else{
      _provider.rideSideWidget = InvoiceWidget(
        id: id,
        bills: bills,
      );
    }
  }
}
