import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/company_information_dialog.dart';
import 'package:my_billbook/dialog/invoice_setting_dialog.dart';
import 'package:my_billbook/dialog/user_account_dialog.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/model/company_information.dart';
import 'package:my_billbook/provider/invoice_number_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/enum.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class SettingWidget extends StatelessWidget {

  final _borderRadius = 5.0;
  final _borderWidth = 1.5;
  final _scrollController = ScrollController();
  ValueNotifier<String> _dueInDays;
  ValueNotifier<String> _dateFormat;
  ValueNotifier<String> _language;
  ValueNotifier<bool> _sendMeCopy;

  @override
  Widget build(BuildContext context) {

    _dueInDays = ValueNotifier<String>(userModel.userSettings.dueInDays);
    _dateFormat = ValueNotifier<String>(userModel.userSettings.dateFormat);
    _language = ValueNotifier<String>(userModel.userSettings.language);
    _sendMeCopy = ValueNotifier<bool>(userModel.userSettings.sendMeCopy);

    return CupertinoScrollbar(
      thickness: 8.0,
      thicknessWhileDragging: 8.0,
      controller: _scrollController,
      isAlwaysShown: true,
      radius: Radius.circular(0),
      radiusWhileDragging: Radius.circular(0),
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView(
          controller: _scrollController,
          children: [
            Text(
              'Settings',
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.w700,
                  fontSize: 25.0),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Name',
                        style: TextStyle(
                            color: MyColors.invoiceTxt,
                            fontWeight: FontWeight.w600,
                            fontSize: 16.0),
                      ),
                      SizedBox(height: 10,),
                      Text(
                        userModel.email,
                        style: TextStyle(
                            color: MyColors.invoiceTxt,
                            fontWeight: FontWeight.w600,
                            fontSize: 15.0),
                      ),
                      SizedBox(height: 10,),
                      FlatButton(
                          onPressed: () {
                            onLogoutTap(context);
                          },
                          materialTapTargetSize: MaterialTapTargetSize
                              .shrinkWrap,
                          minWidth: 0,
                          height: 0,
                          padding: EdgeInsets.zero,
                          child: Text('Logout', style: TextStyle(
                              color: MyColors.accent,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0))
                      ),
                      SizedBox(height: 30,),
                      Text(
                        'Company',
                        style: TextStyle(
                            color: MyColors.invoiceTxt,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      SizedBox(height: 20,),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {
                            onUserAccountTap(context);
                          },
                          title: Text(
                            'User Account',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {
                            onCompanyInformationTap(context);
                          },
                          title: Text(
                            'Company Information',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {},
                          title: Text(
                            'Logo',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {},
                          title: Text(
                            'Payment Instruction',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {},
                          title: Text(
                            'Customer Payment Option',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 30,),
                      Text(
                        'Invoice',
                        style: TextStyle(
                            color: MyColors.invoiceTxt,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      SizedBox(height: 20,),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {
                            commonDialog(context,DialogType.invoiceNumber);
                          },
                          title: Text(
                            'Invoice Number',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Due in (days)',
                              style: TextStyle(
                                  color: MyColors.invoiceTxt,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0)),
                          Spacer(),
                          SizedBox(
                            width: 200,
                            child: ValueListenableBuilder(
                              valueListenable: _dueInDays,
                                builder: (BuildContext context, value,
                                    Widget child) {
                                  return DropdownButtonFormField(
                                      value: value,
                                      isDense: true,
                                      onChanged: (value){
                                        onDueInDaysChange(context,value);
                                      },
                                      style: TextStyle(
                                          color: MyColors.invoiceTxt,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13.0),
                                      decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(_borderRadius),
                                              borderSide: BorderSide(
                                                  color: MyColors.border,
                                                  width: _borderWidth)
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(_borderRadius),
                                              borderSide: BorderSide(
                                                  color: MyColors.border,
                                                  width: _borderWidth)
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(_borderRadius),
                                              borderSide: BorderSide(
                                                  color: MyColors.focusBorder,
                                                  width: _borderWidth)
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius
                                                  .circular(_borderRadius),
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: _borderWidth)
                                          )
                                      ),
                                      items: [
                                        'None',
                                        'Same Day',
                                        '3',
                                        '7',
                                        '21',
                                        '30',
                                        '45',
                                        '60'
                                      ].map((e) {
                                        return DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        );
                                      }).toList());
                                },

                            )
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {},
                          title: Text(
                            'Currency',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {},
                          title: Text(
                            'Tax',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {
                            commonDialog(context,DialogType.note);
                          },
                          title: Text(
                            'Default Note',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {
                            commonDialog(context,DialogType.termsAndCondition);
                          },
                          title: Text(
                            'Default Terms and Conditions',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {
                            commonDialog(context,DialogType.emailMessage);
                          },
                          title: Text(
                            'Default Email Message',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      Ink(
                        color: Colors.transparent,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          onTap: () {},
                          title: Text(
                            'Rename Fields',
                            style: TextStyle(
                                color: MyColors.invoiceTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 13.0),
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      ValueListenableBuilder(
                        valueListenable: _sendMeCopy,
                        builder: (BuildContext context, value, Widget child) {
                          return SwitchListTile(
                            value: value,
                            contentPadding: EdgeInsets.symmetric(vertical: 1),
                            onChanged: (value){
                              onSendMeCopyChanged(context,value);
                            },
                            title: Text(
                              'Send me a copy',
                              style: TextStyle(
                                  color: MyColors.invoiceTxt,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0),
                            ),
                          );
                        },
                      ),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 30,),
                      Text(
                        'General',
                        style: TextStyle(
                            color: MyColors.invoiceTxt,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      SizedBox(height: 20,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Date Format',
                              style: TextStyle(
                                  color: MyColors.invoiceTxt,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0)),
                          Spacer(),
                         ValueListenableBuilder(
                           valueListenable: _dateFormat,
                           builder: (BuildContext context, value, _) {
                             return SizedBox(
                               width: 200,
                               child: DropdownButtonFormField(
                                   value: value,
                                   isDense: true,
                                   onChanged: (value){
                                     onDateFormatChanged(context,value);
                                   },
                                   style: TextStyle(
                                       color: MyColors.invoiceTxt,
                                       fontWeight: FontWeight.w600,
                                       fontSize: 13.0),
                                   decoration: InputDecoration(
                                       contentPadding: EdgeInsets.symmetric(
                                           horizontal: 10),
                                       border: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(
                                               _borderRadius),
                                           borderSide: BorderSide(
                                               color: MyColors.border,
                                               width: _borderWidth)
                                       ),
                                       enabledBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(
                                               _borderRadius),
                                           borderSide: BorderSide(
                                               color: MyColors.border,
                                               width: _borderWidth)
                                       ),
                                       focusedBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(
                                               _borderRadius),
                                           borderSide: BorderSide(
                                               color: MyColors.focusBorder,
                                               width: _borderWidth)
                                       ),
                                       errorBorder: OutlineInputBorder(
                                           borderRadius: BorderRadius.circular(
                                               _borderRadius),
                                           borderSide: BorderSide(
                                               color: Colors.red,
                                               width: _borderWidth)
                                       )
                                   ),
                                   items: [
                                     '05 Apr 2014',
                                     '05/04/2014',
                                     'Apr 05, 2014',
                                     '04/05/2014',
                                     '2014/04/05'
                                   ].map((e) {
                                     return DropdownMenuItem(
                                       child: Text(e),
                                       value: e,
                                     );
                                   }).toList()),
                             );
                           },
                         )
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(
                        thickness: 1,
                        height: 1,
                        color: Colors.black26,
                      ),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              'Language',
                              style: TextStyle(
                                  color: MyColors.invoiceTxt,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.0)),
                          Spacer(),
                          ValueListenableBuilder(
                            valueListenable: _language,
                            builder: (BuildContext context, value,_) {
                              return SizedBox(
                                width: 200,
                                child: DropdownButtonFormField(
                                    value: value,
                                    isDense: true,
                                    onChanged: (value){
                                      onLanguageChanged(context,value);
                                    },
                                    style: TextStyle(
                                        color: MyColors.invoiceTxt,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13.0),
                                    decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                _borderRadius),
                                            borderSide: BorderSide(
                                                color: MyColors.border,
                                                width: _borderWidth)
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                _borderRadius),
                                            borderSide: BorderSide(
                                                color: MyColors.border,
                                                width: _borderWidth)
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                _borderRadius),
                                            borderSide: BorderSide(
                                                color: MyColors.focusBorder,
                                                width: _borderWidth)
                                        ),
                                        errorBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                _borderRadius),
                                            borderSide: BorderSide(
                                                color: Colors.red,
                                                width: _borderWidth)
                                        )
                                    ),
                                    items: [
                                      'English',
                                      'Gujarati',
                                      'Hindi',
                                      'French'
                                    ].map((e) {
                                      return DropdownMenuItem(
                                        child: Text(e),
                                        value: e,
                                      );
                                    }).toList()),
                              );
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void onDueInDaysChange(BuildContext context,value) async{
    showProgress(context);
    var _result = await FirebaseService.updateSettingDueInDays(value);
    Navigator.pop(context);
    if(_result){
      _dueInDays.value = value;
      userModel.userSettings.dueInDays = value;
    }
  }

  void onDateFormatChanged(BuildContext context,value) async{
    showProgress(context);
    var _result = await FirebaseService.updateSettingDateFormat(value);
    Navigator.pop(context);
    if(_result){
      _dateFormat.value = value;
      userModel.userSettings.dateFormat = value;
    }
  }

  void onLanguageChanged(BuildContext context,value) async{
    showProgress(context);
    var _result = await FirebaseService.updateSettingLanguage(value);
    Navigator.pop(context);
    if(_result){
      _language.value = value;
      userModel.userSettings.language = value;
    }
  }

  void commonDialog(BuildContext context,DialogType dialogType) {
    var list = Provider
        .of<InvoiceNumberProvider>(context, listen: false)
        .billsList;
    showDialog(context: context,
        builder: (context) => InvoiceSettingDialog(
          bills: list,
        dialogType: dialogType,));
  }
  void onSendMeCopyChanged(BuildContext context,bool value) async{
    showProgress(context);
    var _result = await FirebaseService.updateSettingSendMeCopy(value);
    Navigator.pop(context);
    if(_result){
      _sendMeCopy.value = value;
      userModel.userSettings.sendMeCopy = value;
    }
  }

  void onUserAccountTap(BuildContext context) {
    showDialog(context: context,
        builder: (context) => UserAccountDialog());
  }

  void onLogoutTap(BuildContext context) {
    // FirebaseService.logOut(context);
  }

  void onCompanyInformationTap(BuildContext context) {
    showDialog(context: context,builder: (context) => CompanyInformationDialog());
  }
}
