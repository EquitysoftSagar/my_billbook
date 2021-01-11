import 'package:flutter/material.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/style/colors.dart';

class AddInvoiceListWidget extends StatelessWidget {
  final bool isCustomer;
  final Customer customer;
  final Item item;

  const AddInvoiceListWidget({Key key,this.isCustomer,this.customer,this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(isCustomer ? customer.name : item.name,style: TextStyle(color: MyColors.text,fontSize: 15,),),
      subtitle:Text(isCustomer ? customer.email : item.price.toString(),style: TextStyle(color: MyColors.text,fontSize: 12,),),
      trailing: RaisedButton(
        onPressed: (){},
        child: Text('IMPORT',style: TextStyle(color: Colors.white,fontSize: 14,)),
      ),
    );
  }
}
