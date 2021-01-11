import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/always_disable_focus_node.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/size_config.dart';

class InvoiceTextField extends StatelessWidget {

  final String labelText;
  final FocusNode focusNode;
  final TextEditingController controller;
  final onSuffixTap;
  final _borderRadius = 5.0;
  final _borderWidth = 1.5;

  const InvoiceTextField({Key key, this.labelText,this.controller,this.focusNode,this.onSuffixTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines:  labelText == 'Note' ? 4 : null,
      style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
      keyboardType: TextInputType.text,
      obscureText: labelText == 'Password' ? true : false,
      focusNode: labelText == 'Date' || labelText == 'Due on'? AlwaysDisableFocusNode(): null,
      // validator: (value){
      //   return 'Error';
      // },
      decoration: InputDecoration(
          isDense: true,
          counterText: '',
          labelText: labelText,
          errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
          labelStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500,),
          hintStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500,height: 2),
          hintText: '',
          // enabled: labelText == 'Date' || labelText == 'Due on'? false : true,
          contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
          // suffixIcon: labelText == 'Date' || labelText == 'Due on'? InkWell(onTap:(){},child: Icon(Icons.calendar_today)) : null,
          suffix: labelText == 'Date' || labelText == 'Due on'? InkWell(onTap:onSuffixTap,child: Icon(Icons.calendar_today)) : null,
          focusColor: MyColors.accent,
          fillColor: Colors.black.withOpacity(0.05),
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
