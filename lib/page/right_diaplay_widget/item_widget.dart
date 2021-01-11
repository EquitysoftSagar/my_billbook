import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/add_item_dialog.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/list_widget/item_list_widget.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/methods.dart';

// ignore: must_be_immutable
class ItemWidget extends StatelessWidget {

  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context,builder: (context) => AddItemDialog(forEdit: false,));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Item List',
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0),
            ),
            Flexible(
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 30,bottom: 70),
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
                        Expanded(
                          flex: 4,
                          child: Text(
                            'Item',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text('Amount',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  color: MyColors.invoiceTxt,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0)),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Actions',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 15.0),
                          ),
                        ),
                        SizedBox(width: 10,),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Divider(
                      color: MyColors.divider,
                      thickness: 1,
                      height: 1,
                    ),
                    StreamBuilder(
                        stream: FirebaseService.getItem(),
                        builder: (context ,AsyncSnapshot<QuerySnapshot> snap){
                          if(snap.connectionState == ConnectionState.waiting){
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }else if(snap.data.docs.length == 0){
                            return Text(
                              'No Item',
                              style: TextStyle(
                                  color: MyColors.invoiceTxt,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20.0),
                            );
                          }else{
                            print('Responce ===> ${snap.data.docs[0].data().toString()}');
                            return Flexible(
                                child: ListView.builder(
                                  itemBuilder: (BuildContext context, int index) {
                                    return ItemListWidget(
                                      index: index,
                                      isInvoiceList: false,
                                      item: Item.fromJson(snap.data.docs[index].data()),
                                      id: snap.data.docs[index].id,
                                      deleteFunction: deleteItem,
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
  void deleteItem(String id)async{
    showProgress(_context);
    await FirebaseService.deleteItem(id);
    Navigator.pop(_context);
  }
  void trashItem(Item item)async{
    showProgress(_context);
    await FirebaseService.addTrash(item);
    Navigator.pop(_context);
  }
}
