import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_billbook/style/colors.dart';

class ItemTextField extends StatelessWidget {

  final String labelText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final _borderRadius = 5.0;
  final _borderWidth = 1.0;
  final _fontSize = 13.0;
  int _price;

  ItemTextField({Key key, this.labelText,this.controller,this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: labelText == 'Price *' || labelText == 'Discount' ? 10 : null,
      style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
      keyboardType: labelText == 'Price' ? TextInputType.number: TextInputType.text,
      inputFormatters: labelText == 'Price *' || labelText == 'Discount' ? <TextInputFormatter>[
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
          case 'Price *':
            if(value.isEmpty){
              return 'Price cannot be blank';
            }
            _price = int.parse(value);
            print('price ===> $_price');
            return null;
          case 'Discount':
            if(value.isNotEmpty && _price != null && int.parse(value) > _price){
              return 'Discount cannot be more than price';
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
