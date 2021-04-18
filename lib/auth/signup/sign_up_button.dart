import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/auth/signup/signup_page_logic.dart';
import 'package:food_education_app/constants.dart';

import 'package:food_education_app/services/service_locator.dart';
// need to change
class SignUpButton extends StatelessWidget {
  SignUpButton({
    Key key,
      @required GlobalKey<FormState> formKeyLogin,
     @required TextEditingController emailController,
     @required TextEditingController passwordController,
  })  : _formKeyLogin = formKeyLogin,
        _emailController = emailController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> _formKeyLogin;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            backgroundColor: kPrimaryColor,
          ),
          onPressed: () {
            if (_formKeyLogin.currentState.validate()) {
              final email = _emailController.text.trim();
              final password = _passwordController.text.trim();
              final loginPageLogic = getIt<SignUpPageLogic>();
             // loginPageLogic.emailLogin(email, password);
            }
          },
          child: Text(
            'Sign Up',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
