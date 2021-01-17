import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/document_item_view_widget.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/page/right_diaplay_widget/invoice_widget.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';

class DocumentNameListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseService.getBills(),
      builder:
          (BuildContext context, AsyncSnapshot<QuerySnapshot> snap) {
        if(snap.connectionState == ConnectionState.waiting){
          print('bills Loading....');
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

  void onDocumentTap(BuildContext context, String id, Bills bills) {
    final _provider = Provider.of<HomePageProvider>(context,listen: false);
    _provider.rideSideWidget = InvoiceWidget(
      id: id,
      bills: bills,
    );
  }
}
