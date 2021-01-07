import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/constants.dart';

class CustomerTextField extends StatelessWidget {

  final String labelText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final _borderRadius = 5.0;
  final _borderWidth = 1.0;
  final _fontSize = 13.0;

  const CustomerTextField({Key key, this.labelText,this.controller,this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
      keyboardType: labelText == 'Phone Number' && labelText == 'Business Number' && labelText == 'Zip'? TextInputType.number: TextInputType.text,
      // obscureText: labelText == 'Password' ? true : false,
      validator: (value){
        switch(labelText){
          case 'Name':
            return 'Name cannot be blank';
          default:
            return null;
        }
      },
      decoration: InputDecoration(
          isDense: true,
          counterText: '',
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
