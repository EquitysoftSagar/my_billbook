import 'package:flutter/material.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/text_field/invoice_number_text_field.dart';

class SettingsInvoiceNumberItemView extends StatelessWidget {
  final Bills bills;
  final int index;
  final _prefixController = TextEditingController();
  final _nextController = TextEditingController();

  SettingsInvoiceNumberItemView({Key key, this.bills,this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _prefixController.text = bills.settingPrefix;
    _nextController.text = bills.settingNext.toString();
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              bills.name,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0)),
          SizedBox(height: 20,),
          Row(
            children: [
              Expanded(
                child: InvoiceNumberTextField(
                  labelText: 'Prefix',
                  controller: _prefixController,
                  onChanged: onPrefixChanged,
                ),
              ),
              SizedBox(width: 20,),
              Expanded(
                child: InvoiceNumberTextField(
                  labelText: 'Next #',
                  controller: _nextController,
                  onChanged: onNextChanged,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  void onPrefixChanged(String value){
    bills.settingPrefix = value;
  }
  void onNextChanged(String value){
    if(value.isNotEmpty){
      bills.settingNext = int.parse(value);
    }
  }
}
