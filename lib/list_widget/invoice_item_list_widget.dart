import 'package:flutter/material.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/style/colors.dart';

class InvoiceItemListWidget extends StatelessWidget {
  final int index;
  final Item item;
  final Function removeFunction;

  const InvoiceItemListWidget({Key key, this.index, this.item,this.removeFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(top: 10, bottom: 10,left: 20,right: 20),
      color: index % 2 == 0 ? Colors.black.withOpacity(0.05) : Colors.white,
      child:  Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              item.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.0),
            ),
          ),
          Expanded(
            child: Text('1',
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: MyColors.invoiceTxt,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0)),
          ),
          Expanded(
            child: Text(item.price.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: MyColors.invoiceTxt,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0)),
          ),
          Expanded(
            child: Text(item.price.toString(),
                textAlign: TextAlign.right,
                style: TextStyle(
                    color: MyColors.invoiceTxt,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.0)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Tooltip(
                  message: 'Delete',
                  child: InkWell(
                    child: Icon(
                      Icons.edit,
                      color: Colors.blueAccent,
                    ),
                    onTap: () {
                      // removeFunction(item);
                    },
                  ),
                ),
                SizedBox(width: 10,),
                Tooltip(
                  message: 'Delete',
                  child: InkWell(
                    child: Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                    onTap: () {
                      removeFunction(item);
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
