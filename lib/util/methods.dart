import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/dialog/progress_dialog.dart';

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
    builder: (context) => Center(child: CircularProgressIndicator( backgroundColor: Colors.white,)),
  );
}

snackBarAlert(GlobalKey<ScaffoldState> scaffoldKey, String message) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(color: Colors.black26,blurRadius: 10)
            ]
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
  ));
}
snackBarSuccess(GlobalKey<ScaffoldState> scaffoldKey, String message) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(color: Colors.black26,blurRadius: 10)
              ]
          ),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.transparent,
  ));
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
