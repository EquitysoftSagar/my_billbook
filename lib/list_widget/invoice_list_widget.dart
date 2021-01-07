import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';

class InvoiceListWidget extends StatelessWidget {
  final int index;

  const InvoiceListWidget({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.only(top: 10,bottom: 10),
      color: index % 2 == 0 ? Colors.black.withOpacity(0.05): Colors.white,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text( // status
              'Pending',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text( // date
              '07 Jan 2021',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text( // No.
              '${index + 1 }',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text( // customer
              'Sagar Panchal',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w500,
                  fontSize: 13.0),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text( // amount
              '13,786',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
