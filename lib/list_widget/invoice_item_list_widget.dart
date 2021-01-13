import 'package:flutter/material.dart';
import 'package:my_billbook/model/invoice_item_model.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/constants.dart';

class InvoiceItemListWidget extends StatelessWidget {
  final int index;
  final InvoiceItemModel item;
  final Function removeFunction;
  final Function updateFunction;

  const InvoiceItemListWidget({Key key, this.index, this.item,this.removeFunction,this.updateFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(top: 10, bottom: 10,left: 20,right: 20),
      color: index % 2 == 0 ? Colors.black.withOpacity(0.05) : Colors.white,
      child:  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Text(
                  item.name,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: MyColors.invoiceTxt,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0),
                ),
              ),
              Expanded(
                child: Text(item.quantity.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: MyColors.invoiceTxt,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0)),
              ),
              Expanded(
                child: Text(Constants.indianCurrencySymbol + item.price.toString(),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: MyColors.invoiceTxt,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0)),
              ),
              Expanded(
                child: Text(Constants.indianCurrencySymbol + (item.discount.isEmpty ? '0' : item.discount),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: MyColors.invoiceTxt,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0)),
              ),
              Expanded(
                child: Text(Constants.indianCurrencySymbol + item.amount,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: MyColors.invoiceTxt,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0)),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Tooltip(
                      message: 'Edit',
                      child: InkWell(
                        child: Icon(
                          Icons.edit,
                          color: Colors.blueAccent,
                        ),
                        onTap: () {
                          updateFunction(item,index);
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
          Visibility(
            visible: item.description.isNotEmpty ? true : false,
            child: Padding(
              padding:  EdgeInsets.only(top: 10),
              child: Text(item.description,style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w400,fontSize: 12),),
            ),
          )
        ],
      ),
    );
  }
}
