import 'package:flutter/material.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/style/colors.dart';

class SettingDefaultEmailMessageItemView extends StatelessWidget {
  final Bills bills;
  final _controller = TextEditingController();
  final _borderRadius = 5.0;
  final _borderWidth = 0.8;

  SettingDefaultEmailMessageItemView({Key key, this.bills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.text = bills.settingDefaultEmailMessage;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(bills.name,
              style: TextStyle(
                  color: MyColors.invoiceTxt,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.0)),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _controller,
            style: TextStyle(color: MyColors.text, fontWeight: FontWeight.w500),
            minLines: 3,
            maxLines: 3,
            onChanged: onChanged,
            decoration: InputDecoration(
                isDense: true,
                counterText: '',
                errorStyle:
                TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                contentPadding:
                EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    borderSide:
                    BorderSide(color: MyColors.border, width: _borderWidth)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    borderSide:
                    BorderSide(color: MyColors.border, width: _borderWidth)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    borderSide: BorderSide(
                        color: MyColors.focusBorder, width: _borderWidth)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(_borderRadius),
                    borderSide:
                    BorderSide(color: Colors.red, width: _borderWidth))),
          )
        ],
      ),
    );
  }

  void onChanged(String value) {
  }
}
