import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';


class EmailSignUpFormField extends StatelessWidget {
  const EmailSignUpFormField({
    Key key,
    @required TextEditingController emailController, @required focusNode
  })  : _emailController = emailController, _emailFocus = focusNode,
        super(key: key);

  final TextEditingController _emailController;
  final FocusNode _emailFocus;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SignUpFormField(
      controller: _emailController,
      textInputType: TextInputType.emailAddress,
      icon: Icons.email,
      hintText: 'Email',
      validationText: 'Please enter your Email',
    );
  }
}

class PasswordSignUpFormField extends StatelessWidget {
  const PasswordSignUpFormField({
    Key key,
    @required TextEditingController passwordController, @required focusNode
  })  : _passwordController = passwordController, _passwordFocus = focusNode,
        super(key: key);

  final TextEditingController _passwordController;
  final FocusNode _passwordFocus;

  @override
  Widget build(BuildContext context) {
    return SignUpFormField(
        controller: _passwordController,
        textInputType: TextInputType.visiblePassword,
        icon: Icons.lock_open,
        hintText: 'Password',
        validationText: 'Please enter your Password',
        obscureText: true);
  }
}

class ConfirmPasswordSignUpFormField extends StatelessWidget {
  const ConfirmPasswordSignUpFormField({
    Key key,
    @required TextEditingController confirmPasswordController, @required focusNode
  })  : _confirmPasswordController = confirmPasswordController, _confirmPasswordFocus = focusNode,
        super(key: key);

  final TextEditingController _confirmPasswordController;
  final FocusNode _confirmPasswordFocus;

  @override
  Widget build(BuildContext context) {
    return SignUpFormField(
        controller: _confirmPasswordController,
        textInputType: TextInputType.visiblePassword,
        icon: Icons.lock_open,
        hintText: 'Password',
        validationText: 'Please enter your Password',
        obscureText: true);
  }
}

class SignUpFormField extends StatelessWidget {
  const SignUpFormField({
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
