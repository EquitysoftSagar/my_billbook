import 'package:flutter/material.dart';
import 'package:my_billbook/firebase/firebase_service.dart';
import 'package:my_billbook/page/sign_up_page.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/style/images.dart';
import 'package:my_billbook/text_field/login_text_field.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:my_billbook/util/routes.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // _emailController.text = 'smeetpanchal857@gmail.com';
    // _passwordController.text = '123456';
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  MyImages.logo,
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 80,),
                LoginTextField(controller: _emailController, labelText: 'Email',),
                SizedBox(height: 20,),
                LoginTextField(controller: _passwordController, labelText: 'Password',),
                SizedBox(height: 30,),
                FlatButton(
                  onPressed: () {
                    onLoginTap(context);
                  },
                  minWidth: 358,
                  height: 52,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: MyColors.buttonTxt, fontWeight: FontWeight.w500),
                  ),
                  color: MyColors.accent,
                ),
                SizedBox(height: 20,),
                FlatButton(
                  onPressed: () {},
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                        color: MyColors.buttonTxtBlue,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Don\'t have an account yet?',
                      style: TextStyle(
                          color: MyColors.buttonTxtGrey,
                          fontWeight: FontWeight.w400),
                    ),
                    FlatButton(
                      onPressed: (){
                        onSignUpTap(context);
                      },
                      minWidth: 70,
                      padding: EdgeInsets.zero,
                      child: Text(
                        'Sign Up',
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
      ),
    );
  }

  void onLoginTap(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      showProgress(context);
      var _result = await FirebaseService.signIn(_emailController.text,_passwordController.text);
      Navigator.pop(context);
      if (_result) {
        Navigator.pushNamedAndRemoveUntil(context, Routes.home, (route) => false);
      }
    }
  }

  void onSignUpTap(BuildContext context) {
    navigateTo(context, SignUpPage());
  }
}
