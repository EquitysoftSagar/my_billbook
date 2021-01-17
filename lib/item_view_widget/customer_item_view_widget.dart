import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/customer_dialog.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/style/colors.dart';

class CustomerItemViewWidget extends StatelessWidget {
  final int index;
  final Customer customer;
  final String id;
  final Function deleteFunction;
  final Function editFunction;

  const CustomerItemViewWidget({Key key, this.index,this.customer,this.id,this.deleteFunction,this.editFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        showDialog(context: context,builder: (context) => CustomerDialog(forEdit: true,customer: customer,id: id,fromInvoice: false,));
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        color: index % 2 == 0 ? Colors.black.withOpacity(0.05) : Colors.white,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              customer.name,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0),
            ),
            Spacer(),
            Row(
              children: [
                Tooltip(
                  message: 'Email',
                  child: InkWell(
                    child: Icon(
                      Icons.email,
                      color: Colors.green,
                    ),
                    onTap: () {},
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
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
                SizedBox(
                  width: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
