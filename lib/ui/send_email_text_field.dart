import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/constants.dart';

class SendEmailTextField extends StatelessWidget {
  final String labelText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final _borderRadius = 5.0;
  final _borderWidth = 0.8;
  final _fontSize = 13.0;
  final Function onChangedFunction;

  const SendEmailTextField({Key key, this.labelText, this.focusNode, this.controller, this.onChangedFunction}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChangedFunction,
      maxLines: labelText == 'Message' ? 5 : 1,
      maxLength: labelText == 'Message' ? 2000 : 100,
      style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
      validator: (value){
        switch(labelText){
          case 'Recipient':
            if(value.isEmpty){
              return 'Please enter recipient email';
            }else if(!Constants.emailRegExp.hasMatch(value)){
              return 'Enter valid email';
            }
            return null;
          default:
            return null;
        }
      },
      decoration: InputDecoration(
          isDense: true,
          counterText: labelText != 'Message'?'':null,
          labelText: labelText,
          errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w500,fontSize: _fontSize),
          labelStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500,fontSize: _fontSize),
          hintStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500,fontSize: _fontSize),
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
    );
  }
}
