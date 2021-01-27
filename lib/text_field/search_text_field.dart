import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';

class SearchTextField extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final _borderRadius = 30.0;
  final _borderWidth = 1.5;

  const SearchTextField({Key key, this.focusNode, this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: MyColors.text,fontWeight: FontWeight.w500),
        decoration: InputDecoration(
            isDense: true,
            counterText: '',
            // labelText: labelText,
          hintText: 'Search...',
            errorStyle: TextStyle(color: Colors.red,fontWeight: FontWeight.w500),
            labelStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500),
            hintStyle: TextStyle(color: MyColors.labelText,fontWeight: FontWeight.w500),
            contentPadding: EdgeInsets.symmetric(horizontal: 20,vertical: 12),
            suffixIcon: InkWell(
              onTap: (){},
                child: Icon(Icons.search,color: Colors.grey,size: 27,)),
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
        ),
      ),
    );
  }
}
