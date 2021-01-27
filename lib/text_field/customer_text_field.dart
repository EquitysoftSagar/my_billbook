
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      maxLength: labelText == 'Phone Number' || labelText == 'Business Number' ? 10 :  labelText == 'Zip' || labelText == 'Zip2' ? 10 : null,
      style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
        inputFormatters: labelText == 'Phone Number' || labelText == 'Business Number' || labelText == 'Zip'? <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ]: [],
      // obscureText: labelText == 'Password' ? true : false,
      validator: (value){
        switch(labelText){
          case 'Name *':
            if(value.isEmpty){
              return 'Name cannot be blank';
            }
            return null;
          case 'Email':
            if(value.isNotEmpty && !Constants.emailRegExp.hasMatch(value)){
              return 'Enter valid email';
            }
            return null;
          case 'Phone Number':
            if(value.isNotEmpty && value.length < 10){
              return 'Enter valid phone number';
            }
            return null;
          case 'Zip':
            if(value.isNotEmpty && value.length < 6){
              return 'Enter valid Zip code';
            }
            return null;
          case 'Zip2':
            if(value.isNotEmpty && value.length < 6){
              return 'Enter valid Zip code';
            }
            return null;
          default:
            return null;
        }
      },
      decoration: InputDecoration(
          isDense: true,
          counterText: '',
          labelText: labelText == 'Zip2' ? 'Zip' : labelText,
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
