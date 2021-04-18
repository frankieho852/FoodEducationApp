import 'package:flutter/material.dart';

import '../../../constants.dart';

class EmailFormField extends StatelessWidget {
  const EmailFormField({
    Key key,
    @required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return LoginFormField(
      controller: _emailController,
      textInputType: TextInputType.emailAddress,
      icon: Icons.email,
      hintText: 'Email',
      validationText: 'Please enter your Email',
    );
  }
}

class PasswordFormField extends StatelessWidget {
  const PasswordFormField({
    Key key,
    @required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return LoginFormField(
        controller: _passwordController,
        textInputType: TextInputType.visiblePassword,
        icon: Icons.lock_open,
        hintText: 'Password',
        validationText: 'Please enter your Password',
        obscureText: true);
  }
}

class LoginFormField extends StatelessWidget {
  const LoginFormField({
    Key key,
    @required TextEditingController controller,
    @required this.textInputType,
    @required this.icon,
    @required this.hintText,
    @required this.validationText,
    this.obscureText = false,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController _controller;
  final TextInputType textInputType;
  final IconData icon;
  final String hintText;
  final String validationText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: kPrimaryColor.withAlpha(100),
        borderRadius: BorderRadius.circular(29.0),
      ),
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: size.width * 0.9,
      child: TextFormField(
          controller: _controller,
          keyboardType: textInputType,
          cursorColor: kPrimaryColor,
          obscureText: obscureText,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: kPrimaryColor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: kPrimaryColor,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
            border: UnderlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
            ),
          ),
          validator: (value) {
            if (value.isEmpty) {
              return validationText;
            }
            return null;
          }),
    );
  }
}
