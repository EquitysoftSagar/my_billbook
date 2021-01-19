import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/item_view_widget/setting_invoice_number_item_view.dart';
import 'package:my_billbook/item_view_widget/settings_default_email_message_item_view.dart';
import 'package:my_billbook/item_view_widget/settings_default_note_item_view.dart';
import 'package:my_billbook/item_view_widget/settings_default_terms_and_condition_item_view.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/enum.dart';
import 'package:my_billbook/util/methods.dart';

class InvoiceSettingDialog extends StatelessWidget {
  final List<Bills> bills;
  final DialogType dialogType;
  final _scrollController = ScrollController();

  InvoiceSettingDialog({Key key, this.bills, @required this.dialogType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 400,
        height: 500,
        padding: EdgeInsets.only(
          bottom: 15,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              alignment: Alignment.centerLeft,
              height: 50,
              decoration: BoxDecoration(
                  color: MyColors.accent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  )),
              padding: EdgeInsets.only(left: 20),
              child: Text(
                dialogType == DialogType.invoiceNumber
                    ? 'Invoice Number'
                    : dialogType == DialogType.note
                        ? 'Default Note'
                        : dialogType == DialogType.termsAndCondition
                            ? 'Default Terms and Conditions'
                            : 'Default Email Message',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Flexible(
              child: CupertinoScrollbar(
                thickness: 6.0,
                thicknessWhileDragging: 6.0,
                controller: _scrollController,
                isAlwaysShown: true,
                radius: Radius.circular(0),
                radiusWhileDragging: Radius.circular(0),
                child: ListView.builder(
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    return dialogType == DialogType.invoiceNumber
                        ? SettingsInvoiceNumberItemView(
                            index: index,
                            bills: bills[index],
                          )
                        : dialogType == DialogType.note
                            ? SettingsDefaultNoteItemView(
                                bills: bills[index],
                              )
                            : dialogType == DialogType.emailMessage
                                ? SettingDefaultEmailMessageItemView(
                                    bills: bills[index],
                                  )
                                : SettingDefaultTermsAndConditionsItemView(
                                    bills: bills[index],
                                  );
                  },
                  itemCount: bills.length,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                  color: Colors.white,
                  textColor: Colors.black,
                ),
                SizedBox(
                  width: 10,
                ),
                RaisedButton(
                  onPressed: () {
                    onSaveTap(context);
                  },
                  child: Text('Save'),
                  color: MyColors.accent,
                  textColor: Colors.white,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void onSaveTap(BuildContext context) async {
    bool _result;
    if(dialogType == DialogType.invoiceNumber){
      showProgress(context);
      _result = await FirebaseService.updateInvoiceNumberBillsSetting(bills);
      if (_result) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    }else if(dialogType == DialogType.note){
      showProgress(context);
      _result = await FirebaseService.updateInvoiceDefaultNote(bills);
      if (_result) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    }
  }
}
