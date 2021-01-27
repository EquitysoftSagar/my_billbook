import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';

class InvoiceDateTextField extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final _borderRadius = 5.0;
  final _borderWidth = 1.5;

  const InvoiceDateTextField({Key key, this.labelText, this.focusNode, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
      keyboardType: TextInputType.text,
      obscureText: labelText == 'Password' ? true : false,
      // validator: (value){
      //   return 'Error';
      // },
      decoration: InputDecoration(
        isDense: true,
        counterText: '',
        labelText: labelText,
        errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
        labelStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500),
        hintStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500),
        contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
        focusColor: MyColors.accent,
        fillColor: Colors.black.withOpacity(0.08),
        filled: true,
        // border: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(_borderRadius),
        //     borderSide: BorderSide(color: MyColors.border,width: _borderWidth)
        // ),
        // enabledBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(_borderRadius),
        //     borderSide: BorderSide(color: MyColors.border,width: _borderWidth)
        // ),
        // focusedBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(_borderRadius),
        //     borderSide: BorderSide(color: MyColors.focusBorder,width: _borderWidth)
        // ),
        // errorBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(_borderRadius),
        //     borderSide: BorderSide(color: Colors.red,width: _borderWidth)
        // )
      ),
    );
  }
}
