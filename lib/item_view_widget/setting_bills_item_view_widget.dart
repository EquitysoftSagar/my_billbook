import 'package:flutter/material.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/settings_bills_text_field.dart';

class SettingsBillsItemViewWidget extends StatelessWidget {
  final Bills bills;
  final int index;
  final String id;
  final _prefixController = TextEditingController();
  final _nextController = TextEditingController();

  SettingsBillsItemViewWidget({Key key, this.bills,this.index,this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          SettingsBillsTextField(
            labelText: 'Prefix',
            controller: _prefixController,
          ),
          SizedBox(height: 20,),
          SettingsBillsTextField(
            labelText: 'Next #',
            controller: _nextController,
          ),
        ],
      ),
    );
  }
}
