import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/customer_item_view_widget.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/methods.dart';

class CustomerListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseService.getCustomer(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
          if (snap.hasData) {
            return snap.data.docs.length == 0 ?
            Text(
              'No Customer',
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.0),
            ) : Flexible(
              child: ListView.builder(
                itemBuilder: (BuildContext context,
                    int index) {
                  return CustomerItemViewWidget(
                    index: index,
                    customer: Customer.fromJson(
                        snap.data.docs[index].data()),
                    id: snap.data.docs[index].id,
                    deleteFunction: (String id){
                      deleteCustomer(id, context);
                    },
                  );
                },
                itemCount: snap.data.docs.length,
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
  void deleteCustomer(String id,BuildContext context)async{
    showProgress(context);
    await FirebaseService.deleteCustomer(id);
    Navigator.pop(context);
  }
}
