import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/model/user.dart';
import 'package:my_billbook/page/home_page.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/ui/sign_up_text_field.dart';
import 'package:my_billbook/util/methods.dart';

class SignUpPage extends StatelessWidget {

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _companyNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final _displayEmailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _fieldBetweenSpace = 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SignUpTextField(labelText: 'FirstName', controller: _firstNameController,),SizedBox(height: _fieldBetweenSpace,),
              SignUpTextField(labelText: 'LastName (optional)', controller: _lastNameController,),SizedBox(height: _fieldBetweenSpace,),
              SignUpTextField(labelText: 'Company Name', controller: _companyNameController,),SizedBox(height: _fieldBetweenSpace,),
              SignUpTextField(labelText: 'Email', controller: _emailController,),SizedBox(height: _fieldBetweenSpace,),
              SignUpTextField(labelText: 'Invoice display email', controller: _displayEmailController,),SizedBox(height: _fieldBetweenSpace,),
              SignUpTextField(labelText: 'Password', controller: _passwordController,),SizedBox(height: 30,),
              FlatButton(
                onPressed: () {
                  onSignUpTap(context);
                },
                minWidth: 358,
                height: 52,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                child: Text(
                  'Sing up',
                  style: TextStyle(
                      color: MyColors.buttonTxt, fontWeight: FontWeight.w500),
                ),
                color: MyColors.accent,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(
                        color: MyColors.buttonTxtGrey,
                        fontWeight: FontWeight.w400),
                  ),
                  FlatButton(
                    onPressed: (){
                     onLoginTap(context);
                    },
                    minWidth: 70,
                    padding: EdgeInsets.zero,
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: MyColors.buttonTxtBlue,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void onSignUpTap(BuildContext context) async{
    if(_formKey.currentState.validate()){
      showProgress(context);
      var u = UserModel();
      u.firstName = _firstNameController.text;
      u.lastName = _lastNameController.text;
      u.companyName = _companyNameController.text;
      u.email = _emailController.text;
      u.displayEmail = _displayEmailController.text;
      u.password = _passwordController.text;
      u.status = 1;
      u.createdAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
      u.updatedAt = Timestamp.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch);
     var _result =  await FirebaseService.signUp(u);
      Navigator.pop(context);
      if(_result){
        navigateTo(context, HomePage());
      }
    }
  }

  void onLoginTap(BuildContext context) {
    Navigator.pop(context);
  }
}
