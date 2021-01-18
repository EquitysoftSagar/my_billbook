import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/invoice_number_dialog.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/provider/setting_provider.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:provider/provider.dart';

class SettingWidget extends StatelessWidget {

  final _borderRadius = 5.0;
  final _borderWidth = 1.5;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20,top: 20),
      child: ListView(
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
            padding: const EdgeInsets.only(left: 5,right: 5,bottom: 20),
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
                      firebaseUser.email,
                      style: TextStyle(
                          color: MyColors.invoiceTxt,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0),
                    ),
                    SizedBox(height: 10,),
                    FlatButton(
                        onPressed: (){},
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minWidth: 0,
                        height: 0,
                        padding: EdgeInsets.zero,
                        child: Text('Logout',style: TextStyle(
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
                        onTap: (){},
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
                        onTap: (){},
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
                        onTap: (){},
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
                        onTap: (){},
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
                        onTap: (){},
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
                        onTap: (){
                          onInvoiceNumberTap(context);
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
                        Consumer<SettingProvider>(
                          builder: (BuildContext context, provider, Widget child) {
                            return SizedBox(
                              width: 200,
                              child: DropdownButtonFormField(
                                  value: provider.dueInDays,
                                  isDense: true,
                                  onChanged: (value){
                                    onDueInDaysChange(value,context);
                                  },
                                  style: TextStyle(
                                      color: MyColors.invoiceTxt,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding:EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.border,width: _borderWidth)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.border,width: _borderWidth)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.focusBorder,width: _borderWidth)
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: Colors.red,width: _borderWidth)
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
                                  }).toList()),
                            );
                          },
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
                        onTap: (){},
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
                        onTap: (){},
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
                        onTap: (){},
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
                        onTap: (){},
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
                        onTap: (){},
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
                    Ink(
                      color: Colors.transparent,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 1),
                        onTap: (){},
                        title: Text(
                          'Send me a copy',
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
                        Consumer<SettingProvider>(
                          builder: (BuildContext context, provider, Widget child) {
                            return SizedBox(
                              width: 200,
                              child: DropdownButtonFormField(
                                  value: provider.dateFormat,
                                  isDense: true,
                                  onChanged: (value){
                                    onDateFormatChanged(value,context);
                                  },
                                  style: TextStyle(
                                      color: MyColors.invoiceTxt,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding:EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.border,width: _borderWidth)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.border,width: _borderWidth)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.focusBorder,width: _borderWidth)
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: Colors.red,width: _borderWidth)
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
                        ),
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
                        Consumer<SettingProvider>(
                          builder: (BuildContext context, provider, Widget child) {
                            return SizedBox(
                              width: 200,
                              child: DropdownButtonFormField(
                                  value: provider.language,
                                  isDense: true,
                                  onChanged: (value){
                                    onLanguageChanged(value,context);
                                  },
                                  style: TextStyle(
                                      color: MyColors.invoiceTxt,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.0),
                                  decoration: InputDecoration(
                                      contentPadding:EdgeInsets.symmetric(horizontal: 10),
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.border,width: _borderWidth)
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.border,width: _borderWidth)
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: MyColors.focusBorder,width: _borderWidth)
                                      ),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(_borderRadius),
                                          borderSide: BorderSide(color: Colors.red,width: _borderWidth)
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void onDueInDaysChange(value,context) {
    Provider.of<SettingProvider>(context,listen: false).dueInDays = value;
  }

  void onDateFormatChanged(value, BuildContext context) {
    Provider.of<SettingProvider>(context,listen: false).dateFormat = value;
  }
  void onLanguageChanged(value, BuildContext context) {
    Provider.of<SettingProvider>(context,listen: false).language = value;
  }

  void onInvoiceNumberTap(BuildContext context) {
    showDialog(context: context,builder: (context) => InvoiceNumberDialog());
  }
}
