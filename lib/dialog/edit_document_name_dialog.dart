import 'package:flutter/material.dart';
import 'package:my_billbook/provider/home_page_provider.dart';
import 'package:my_billbook/style/colors.dart';

class EditDocumentNameDialog extends StatelessWidget {
  final _borderRadius = 5.0;
  final _borderWidth = 1.5;
  final _controller = TextEditingController();
  final HomePageProvider provider;


  final String title;
   EditDocumentNameDialog({Key key, this.title,this.provider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    _controller.text = title;
    return Dialog(
        insetAnimationDuration: Duration(seconds: 8),
        insetAnimationCurve: Curves.bounceInOut,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          width: 400,
          padding: EdgeInsets.only(bottom: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                height: 50,
                decoration: BoxDecoration(
                    color: MyColors.accent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )),
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Document Name',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: TextFormField(
                  controller: _controller,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                      labelText: 'Document Name *',
                      isDense: true,
                      contentPadding: EdgeInsets.all(15),
                      labelStyle: TextStyle(
                          color: MyColors.accent,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_borderRadius),
                          borderSide: BorderSide(width: _borderWidth)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_borderRadius),
                          borderSide: BorderSide(
                              color: MyColors.border, width: _borderWidth)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_borderRadius),
                          borderSide: BorderSide(
                              color: MyColors.focusBorder, width: _borderWidth)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(_borderRadius),
                          borderSide: BorderSide(
                              color: Colors.red, width: _borderWidth))),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 20,),
                  Visibility(
                    visible: title == 'Invoice' ? false : true,
                    child: RaisedButton(
                      onPressed: () {
                        onDeleteTap(context);
                      },
                      child: Text('Delete'),
                      color: Colors.redAccent,
                      textColor: Colors.white,
                    ),
                  ),
                  Spacer(),
                  RaisedButton(
                    onPressed: () {Navigator.pop(context);},
                    child: Text('Cancel'),
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                  SizedBox(width: 10,),
                  RaisedButton(
                    onPressed: () {},
                    child: Text('Save'),
                    color: MyColors.accent,
                    textColor: Colors.white,
                  ),
                  SizedBox(width: 20,),
                ],
              )
            ],
          ),
        ));
  }

  void onDeleteTap(BuildContext context) {
    provider.deleteDocument = title;
    Navigator.pop(context);
  }
}
