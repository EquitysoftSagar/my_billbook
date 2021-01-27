import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_billbook/style/colors.dart';

class CompanyInformationTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final _borderRadius = 5.0;
  final _borderWidth = 1.5;

  const CompanyInformationTextField({Key key, this.labelText, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: labelText == 'Phone Number' || labelText == 'Business Number' ? 10 : null,
      style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
      inputFormatters: labelText == 'Zip' || labelText == 'Phone Number' || labelText == 'Business Number' ? <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ]:[],
      validator: (value){
        switch(labelText){
          case 'Company Name':
            if(value.isEmpty){
              return 'Company name cannot be blank';
            }
            return null;
          case 'Phone Number':
            if(value.isNotEmpty && value.length < 10){
              return 'Enter valid phone number';
            }
            return null;
          case 'Business Number':
            if(value.isNotEmpty && value.length < 10){
              return 'Enter valid business number';
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
          errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
          labelStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500),
          hintStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500),
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
