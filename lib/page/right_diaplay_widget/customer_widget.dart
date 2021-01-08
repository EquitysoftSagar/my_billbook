import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/add_customer_dialog.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/list_widget/customer_widget_list.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/methods.dart';

// ignore: must_be_immutable
class CustomerWidget extends StatelessWidget {

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context, builder: (context) => AddCustomerDialog(forEdit: false,));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Customer List',
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 30, bottom: 70),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(color: MyColors.boxShadow, blurRadius: 6)
                    ]),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Text(
                          'Customer',
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                        Spacer(),
                        Text(
                          'Actions',
                          style: TextStyle(
                              color: MyColors.invoiceTxt,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0),
                        ),
                        SizedBox(width: 20,),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Divider(
                      color: MyColors.divider,
                      thickness: 1,
                      height: 1,
                    ),
                    StreamBuilder(
                        stream: FirebaseService.getCustomer(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snap) {
                          if (snap.connectionState == ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snap.data.docs.length == 0) {
                            return Text(
                              'No Customer',
                              style: TextStyle(
                                  color: MyColors.invoiceTxt,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            );
                          } else {
                            return Expanded(
                                child: ListView.builder(
                                  itemBuilder: (BuildContext context,
                                      int index) {
                                    return CustomerListWidget(
                                      index: index,
                                      customer: Customer.fromJson(
                                          snap.data.docs[index].data()),
                                      id: snap.data.docs[index].id,
                                      deleteFunction: deleteCustomer,
                                    );
                                  },
                                  itemCount: snap.data.docs.length,
                                ));
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  void deleteCustomer(String id)async{
    showProgress(_context);
    await FirebaseService.deleteCustomer(id);
    Navigator.pop(_context);
  }
}
