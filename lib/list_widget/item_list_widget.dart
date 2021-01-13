import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/item_dialog.dart';

import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/style/colors.dart';

class ItemListWidget extends StatelessWidget {
  final int index;
  final Item item;
  final String id;
  final Function deleteFunction;

  const ItemListWidget({Key key, this.index,this.item,this.id,this.deleteFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showDialog(context: context,builder: (context) => ItemDialog(forEdit: true,item: item,id: id,fromInvoice: false,));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        color: index % 2 == 0 ? Colors.black.withOpacity(0.05) : Colors.white,
        child:  Row(
          children: [
            SizedBox(width: 10,),
            Expanded(
              flex: 4,
              child: Text(
                item.name,
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: MyColors.invoiceTxt,
                    fontWeight: FontWeight.w600,
                    fontSize: 15.0),
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(item.price.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: MyColors.invoiceTxt,
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0)),
            ),
              Spacer(),
              Tooltip(
                message: 'Delete',
                child: InkWell(
                  child: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onTap: () {
                    deleteFunction(id);
                  },
                ),
              ),
            SizedBox(width: 10,),
          ],
        ),
      ),
    );
  }
}
