import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_billbook/model/document.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/constants.dart';

class InvoiceListItemViewWidget extends StatelessWidget {
  final int index;
  final Documents documents;

  const InvoiceListItemViewWidget({Key key, this.index,this.documents}) : super(key: key);
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
              documents.documentStatus,
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
              DateFormat('dd-MM-yyyy').format(documents.date.toDate()),
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
              documents.customer.name,
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
              '${Constants.indianCurrencySymbol}${documents.amountDue}',
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
