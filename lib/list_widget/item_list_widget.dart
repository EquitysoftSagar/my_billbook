import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/item_list_view_widget.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/methods.dart';

class ItemListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            // print('Responce ===> ${snap.data.docs[0].data().toString()}');
            return Flexible(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return ItemListViewWidget(
                      index: index,
                      item: Item.fromJson(snap.data.docs[index].data()),
                      id: snap.data.docs[index].id,
                      deleteFunction: (String id){
                        deleteItem(context,id);
                      },
                    );
                  },
                  itemCount: snap.data.docs.length,
                ));
          }
        });
  }
  void deleteItem(BuildContext context , String id)async{
    showProgress(context);
    await FirebaseService.deleteItem(id);
    Navigator.pop(context);
  }
  // void trashItem(BuildContext context , Item item)async{
  //   showProgress(context);
  //   await FirebaseService.addTrash(item);
  //   Navigator.pop(context);
  // }
}
