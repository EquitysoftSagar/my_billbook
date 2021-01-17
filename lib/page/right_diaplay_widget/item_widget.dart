import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/item_dialog.dart';
import 'package:my_billbook/item_view_widget/item_list_view_widget.dart';
import 'package:my_billbook/list_widget/item_list_widget.dart';
import 'package:my_billbook/style/colors.dart';

class ItemWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context,builder: (context) => ItemDialog(forEdit: false,fromInvoice: false,));
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
                    ItemListWidget()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
