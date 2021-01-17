import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/import_item_view_widget.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/style/colors.dart';

class ImportCustomerItemDialog extends StatelessWidget {

  final String headerTitle;
  BuildContext context;

  ImportCustomerItemDialog({Key key, this.headerTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Dialog(
        insetAnimationDuration: Duration(seconds: 8),
        insetAnimationCurve: Curves.bounceInOut,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 400,
          height: 500,
          padding: EdgeInsets.only(bottom: 15,),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                  headerTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                    stream: headerTitle == 'Customer List' ? FirebaseService.getCustomer() : FirebaseService.getItem(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                      if (snap.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snap.data.docs.length == 0) {
                        return Text(
                          headerTitle == 'Customer List'? 'No Customer': 'No Items',
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0),
                        );
                      } else {
                        return ListView.builder(
                          itemBuilder: (BuildContext context,
                              int index) {
                            return ImportItemViewWidget(
                             isCustomer: headerTitle == 'Customer List' ? true : false ,
                              customer: headerTitle == 'Customer List' ? Customer.fromJson(snap.data.docs[index].data()) :null,
                              item: headerTitle == 'Items List' ? Item.fromJson(snap.data.docs[index].data()) :null,
                              onImport: onImport,
                            );
                          },
                          itemCount: snap.data.docs.length,
                        );
                      }
                    }),
              ),
              SizedBox(height: 20,),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding:  EdgeInsets.only(right: 20),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                ),
              ),
              // Row(
              //   children: [
              //     SizedBox(width: 10,),
              //     FlatButton(
              //       onPressed: () {
              //         Navigator.pop(context);
              //         showDialog(context: context,builder: (context) =>  headerTitle == 'Customer List' ? CustomerDialog(forEdit: false,): ItemDialog(forEdit: false,fromInvoice: true,));
              //       },
              //       child: Text('Add New'),
              //       textColor: MyColors.accent,
              //     ),
              //     Spacer(),
              //
              //     SizedBox(width: 10,),
              //   ],
              // )
            ],
          ),
        ));
  }

  void onImport(Item item,Customer customer){
    if(customer != null){
      // provider.addInvoiceCustomer = customer;\
      Navigator.pop(context,customer);
    }else{
      // provider.addInvoiceItem = item;
      Navigator.pop(context,item);
    }
  }
}
