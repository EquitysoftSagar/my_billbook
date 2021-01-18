import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/setting_bills_item_view_widget.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/methods.dart';

class InvoiceNumberDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 400,
        height: 500,
        padding: EdgeInsets.only(bottom: 15,),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              height: 50,
              decoration: BoxDecoration(
                  color: MyColors.accent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )),
              padding: EdgeInsets.only(left: 20),
              child: Text(
                'Invoice Number',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
                child: StreamBuilder(
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
                      return ListView.builder(itemBuilder: (BuildContext context, int index) {
                        return SettingsBillsItemViewWidget(
                          index: index,
                          id: snap.data.docs[index].id,
                          bills: Bills.fromJson(snap.data.docs[index].data()),
                        );
                      },
                        itemCount: snap.data.docs.length,
                      );
                    }
                  },
                )
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                  color: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    onSaveTap(context);
                  },
                  child: Text('Save'),
                  color: MyColors.accent,
                  textColor: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onSaveTap(BuildContext context) {
    // showProgress(context);
  }
}
