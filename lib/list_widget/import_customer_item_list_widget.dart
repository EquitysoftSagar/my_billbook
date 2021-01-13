import 'package:flutter/material.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/model/item.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';

class InvoiceCustomerItemImportListWidget extends StatelessWidget {
  final bool isCustomer;
  final Customer customer;
  final Item item;
  final Function onImport;

  const InvoiceCustomerItemImportListWidget({Key key,this.isCustomer,this.customer,this.item,this.onImport}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(isCustomer ? customer.name : item.name,style: TextStyle(color: MyColors.text,fontSize: 15,),),
      subtitle:Text(isCustomer ? customer.email : item.price,style: TextStyle(color: MyColors.text,fontSize: 12,),),
      trailing: RaisedButton(
        onPressed: (){
          onImport(item,customer);
        },
        child: Text('IMPORT',style: TextStyle(color: Colors.white,fontSize: 14,)),
      ),
    );
  }
}
