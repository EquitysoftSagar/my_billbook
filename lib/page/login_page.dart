import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_billbook/style/colors.dart';
import 'package:my_billbook/style/images.dart';
import 'package:my_billbook/ui/login_text_field.dart';
import 'package:my_billbook/util/constants.dart';
import 'package:my_billbook/util/methods.dart';
import 'package:my_billbook/util/my_shared_preference.dart';
import 'package:my_billbook/util/size_config.dart';

import 'home_page.dart';

class LoginPage extends StatelessWidget {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _firebaseAuth;

  @override
  Widget build(BuildContext context) {
    _emailController.text = 'smeetpanchal857@gmail.com';
    _passwordController.text = '123456';
    return Scaffold(
      key: _scaffoldKey,
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
                SizedBox(
                  height: 80,
                ),
                LoginTextField(
                  controller: _emailController,
                  labelText: 'Email',
                ),
                SizedBox(
                  height: 20,
                ),
                LoginTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                ),
                SizedBox(
                  height: 30,
                ),
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
                SizedBox(
                  height: 20,
                ),
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
                      onPressed: () {},
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

  void onLoginTap(BuildContext context) {
    if (_formKey.currentState.validate()) {
      authenticateUser(context);
    }
  }

  void authenticateUser(BuildContext context) async {
    if (!await isInternetConnected()) {
      snackBarAlert(_scaffoldKey, 'No Internet Connection');
    } else {
      showProgress(context);
      try {
        _firebaseAuth = FirebaseAuth.instance;
        var _result = await _firebaseAuth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
        print('token ===> ${_result.user.uid}');
        await SaveValue.string(Keys.userId, _result.user.uid);
        Constants.userId = _result.user.uid;
        Navigator.pop(context);
        navigateTo(context, HomePage());
      } on FirebaseAuthException catch (error) {
        Navigator.pop(context);
        print('error code ==> ${error.code}');
        if (error.code == 'user-not-found') {
          snackBarAlert(_scaffoldKey, 'User is not found with this email');
        } else if (error.code == 'email-already-in-use') {
          snackBarAlert(
              _scaffoldKey, 'The account already exists for that email.');
        } else if (error.code == 'wrong-password') {
          snackBarAlert(_scaffoldKey, 'Password is wrong');
        } else if (error.code == 'too-many-requests') {
          snackBarAlert(_scaffoldKey, 'too-many-requests try again after some time');
        }

      } catch (e) {
        Navigator.pop(context);
        snackBarAlert(_scaffoldKey, 'something went wrong try again later');
        print('error on Login ===> $e');
      }
    }
  }
}
