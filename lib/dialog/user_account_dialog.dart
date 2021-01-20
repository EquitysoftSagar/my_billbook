import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/user_account_text_field.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';

class UserAccountDialog extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    _firstNameController.text = userModel.firstName ?? '';
    _lastNameController.text = userModel.lastName ?? '';
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 400,
        padding: EdgeInsets.only(bottom: 15,),
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
              child: Text('User Account',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Form(
                    key:_formKey,
                    child: UserAccountTextField(
                      labelText: 'First Name',
                      controller: _firstNameController,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  UserAccountTextField(
                    labelText: 'Last Name',
                    controller: _lastNameController,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 20,
                ),
                FlatButton(onPressed: (){}, child: Text('RESET YOUR PASSWORD')),
                Spacer(),
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
      ),
    );
  }

  void onSaveTap(BuildContext context) {
    if(_formKey.currentState.validate()){
      updateUserName(context);
    }
  }
  void updateUserName(BuildContext context)async{
    showProgress(context);
    var _result = await FirebaseService.updateUserNames(_firstNameController.text, _lastNameController.text);
    if(_result){
      Navigator.pop(context);
      Navigator.pop(context);
    }else{
      Navigator.pop(context);
    }
  }
}
