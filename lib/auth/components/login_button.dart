import 'package:flutter/material.dart';
import 'package:food_education_app/auth/login/login_page_logic.dart';

import 'package:food_education_app/constants.dart';
import 'package:food_education_app/services/service_locator.dart';


class LoginButton extends StatelessWidget {
  LoginButton({
    Key key,
  @required GlobalKey<FormState> formKeyLogin,
    @required TextEditingController emailController,
    @required TextEditingController passwordController,
    @required bool loading,
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
              final loginPageLogic = getIt<LoginPageLogic>();
              loginPageLogic.emailLogin(email, password);
            }
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
