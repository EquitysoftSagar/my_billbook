import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  final String title;
  final Function onYesTap;

  const MyAlertDialog({Key key, this.title,this.onYesTap}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title,style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 22,
        color: Colors.black
      ),),
      actions: [
        FlatButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text('Cancel')),
        FlatButton(onPressed: (){
          Navigator.pop(context);
          onYesTap();
        }, child: Text('Yes')),
      ],
    );
  }
}
