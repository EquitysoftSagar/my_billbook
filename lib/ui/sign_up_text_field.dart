import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/constants.dart';

class SignUpTextField extends StatelessWidget {
  final String labelText;
  // final FocusNode focusNode;
  final TextEditingController controller;
  final _borderRadius = 5.0;
  final _borderWidth = 1.5;

  const SignUpTextField({Key key, this.labelText, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
        // keyboardType: TextInputType.text,
        obscureText: labelText == 'Password' ? true : false,
        validator: (value){
          switch(labelText){
            case 'FirstName':
              if(value.isEmpty){
                return 'Please enter your password';
              }
              return null;
            case 'Email':
              if(value.isEmpty){
                return 'Please enter your email';
              }else if(!Constants.emailRegExp.hasMatch(value)){
                return 'Please enter valid email';
              }
              return null;
            case 'Invoice display email':
              if(value.isEmpty){
                return 'Please enter your invoice email';
              }else if(!Constants.emailRegExp.hasMatch(value)){
                return 'Please enter valid email';
              }
              return null;
            case 'Password':
              if(value.isEmpty){
                return 'Please enter your password';
              }
              return null;
            default :
              return null;
          }
        },
        decoration: InputDecoration(
            isDense: true,
            counterText: '',
            labelText: labelText,
            errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
            labelStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500),
            hintStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500),
            // hintText: labelText,
            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
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
      ),
    );
  }
}
