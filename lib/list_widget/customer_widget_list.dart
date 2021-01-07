import 'package:flutter/material.dart';
import 'package:my_billbook/model/customer.dart';
import 'package:my_billbook/style/colors.dart';

class CustomerListWidget extends StatelessWidget {
  final int index;
  final Customer customer;

  const CustomerListWidget({Key key, this.index,this.customer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                width: 20,
              ),
              Tooltip(
                message: 'Delete',
                child: InkWell(
                  child: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                  ),
                  onTap: () {},
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
