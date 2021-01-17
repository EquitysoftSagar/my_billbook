import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/edit_document_dialog.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/style/images.dart';

class DocumentItemViewWidget extends StatelessWidget {
  final Bills bills;
  final int index;
  final String id;
  final Function onTap;

  DocumentItemViewWidget({Key key, this.bills,this.index,this.id,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.only(left: 30, right: 10),
        onTap: (){
          onTap(id,bills);
        },
        selectedTileColor: Colors.blueAccent,
        title: Text(
          bills.name,
          style: TextStyle(
              color: MyColors.drawerTxt,
              fontWeight: FontWeight.w600,
              fontSize: 13.0),
        ),
        trailing: IconButton(
          icon: Image.asset(
            MyImages.threeDot,
            color: MyColors.drawerTxt,
            height: 10,
            width: 10,
          ),
          onPressed: (){
            onMenuTap(context);
          },
        ));
  }

  void onMenuTap(BuildContext context) {
    showDialog(context: context,builder: (context) => EditDocumentDialog(bills: bills,id: id,index: index,));
  }
}
