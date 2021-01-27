import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/model/bills.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/util/methods.dart';

// ignore: must_be_immutable
class AddDocumentDialog extends StatelessWidget {
  final _borderRadius = 5.0;
  final _borderWidth = 1.5;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  //fef

  final String title;

  AddDocumentDialog({Key key, this.title,}) : super(key: key);

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
                  'Add a new category',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  children: [
                    Text('Type the name of the document you want to create.',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: _controller,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Enter document name';
                          }
                          return null;
                        },
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
                                borderRadius:
                                    BorderRadius.circular(_borderRadius),
                                borderSide: BorderSide(width: _borderWidth)),
                            enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(_borderRadius),
                                borderSide: BorderSide(
                                    color: MyColors.border,
                                    width: _borderWidth)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(_borderRadius),
                                borderSide: BorderSide(
                                    color: MyColors.focusBorder,
                                    width: _borderWidth)),
                            errorBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(_borderRadius),
                                borderSide: BorderSide(
                                    color: Colors.red, width: _borderWidth))),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    onPressed: () {
                      onSaveTap(context);
                    },
                    child: Text('Save'),
                    color: MyColors.accent,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void onSaveTap(BuildContext context) {
    if (_formKey.currentState.validate()) {
      addBills(context);
    }
  }
  void addBills(BuildContext context)async{
    showProgress(context);
    var b = Bills();
    b.name = _controller.text;
    b.userId = firebaseUser.uid;
    b.createdAt = Timestamp.fromDate(DateTime.now());
    b.updatedAt = Timestamp.fromDate(DateTime.now());
    var _result = await FirebaseService.addBills(b);
    if(_result){
      Navigator.pop(context);
      Navigator.pop(context);
    }else{
      Navigator.pop(context);
    }
  }
}
