import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_billbook/style/colors.dart';

class TaxDiscountTextField extends StatelessWidget {
  final String labelText;
  // final FocusNode focusNode;
  final TextEditingController controller;
  final _borderRadius = 5.0;
  final _borderWidth = 1.0;
  final _fontSize = 13.0;

  const TaxDiscountTextField({Key key, this.labelText, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
      inputFormatters: labelText == 'Tax label *' ||  labelText == 'Second Tax label' ? []: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      // obscureText: labelText == 'Password' ? true : false,
      // validator: (value){
      //
      // },
      validator: (value){
        switch(labelText){
          case "Tax label *":
            if(value.isEmpty){
              return "Please enter tax label";
            }
            return null;
          case "Second Tax label":
            if(value.isEmpty){
              return "Please enter tax label";
            }
            return null;
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
