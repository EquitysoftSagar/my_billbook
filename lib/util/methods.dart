import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:my_billbook/model/user.dart';
import 'package:my_billbook/util/constants.dart';

import 'my_shared_preference.dart';

void navigateTo<T>(BuildContext context, Widget widget,
    {ValueChanged<T> result}) {
  if (result != null) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget))
        .then((value) => result(value));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}

void showProgress(BuildContext context /*String title*/) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
        child: CircularProgressIndicator(
      backgroundColor: Colors.white,
    )),
  );
}

void toastError(
  String message,
) {
  Fluttertoast.showToast(
    msg: message,
    timeInSecForIosWeb: 2,
    fontSize: 25,
    webBgColor: "linear-gradient(to right, #DC1C13, #EA4C46)",
  );
}

void toastSuccess(
  String message,
) {
  Fluttertoast.showToast(
      msg: message,
      timeInSecForIosWeb: 2,
      fontSize: 25,
      textColor: Colors.white);
}

Future<bool> isInternetConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    return true;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    return true;
  }
  return false;
}

Future<String> getDateFromDatePicker(BuildContext context,DateTime initialDate) async {
  return DateFormat('dd-MM-yyyy').format(await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1999),
      lastDate: DateTime(2025)));
}
String timeStampToString(String format,Timestamp timestamp){
  var dateTime = timestamp.toDate();
  return DateFormat(format).format(dateTime);
}
String dateTimeToString(String format,DateTime dateTime){
  return DateFormat(format).format(dateTime);
}