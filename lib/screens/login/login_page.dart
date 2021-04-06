import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fyp_firebase_login/constants.dart';
import 'package:fyp_firebase_login/constants.dart';
import 'package:fyp_firebase_login/screens/login/login_page_logic.dart';
import 'package:fyp_firebase_login/services/service_locator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../auth_service.dart';

class LoginPage extends StatefulWidget {
  final AuthService authService;

  LoginPage({
    Key key,
    @required this.authService,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

//  todo: Login page UI
// todo: Support email & FB & google now. If you want to support phone number, you can design related UI to login page and sign up page

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final loginLogic = getIt<LoginPageLogic>();
    loginLogic.setup(widget.authService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading ? LoadingScreen() : LoginScreen(),
    );
  }

  // todo: login Page dialog
  void _showErrorDialog(String title, String content) {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: Text('Retry'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      // Login Form
      LoginForm(),
      // Sign Up Button
      SignUpButton(),
    ]));
  }
}

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKeyLogin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor.withAlpha(100),
              borderRadius: BorderRadius.circular(29.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: size.width * 0.9,
            child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                cursorColor: kPrimaryColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.mail,
                    color: kPrimaryColor,
                  ),
                  hintText: 'Email',
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
                    return 'Please enter your Email';
                  }
                  return null;
                }),
          ),
          Container(
            decoration: BoxDecoration(
              color: kPrimaryColor.withAlpha(100),
              borderRadius: BorderRadius.circular(29.0),
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            width: size.width * 0.9,
            child: TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              cursorColor: kPrimaryColor,
              obscureText: true,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.lock_open,
                  color: kPrimaryColor,
                ),
                hintText: 'Password',
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
                  return 'Please enter your Password';
                }
                return null;
              },
            ),
          ),
          Container(
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
                    _emailLogin();
                  }
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                widget.showForgotPW();
              },
              child: Text('Forgot password?'),
              style: TextButton.styleFrom(
                primary: Colors.grey[700],
              )),
          Row(children: <Widget>[
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 15.0),
                  child: Divider(
                    color: Colors.black,
                    height: 50,
                  )),
            ),
            Text("OR"),
            Expanded(
              child: new Container(
                  margin: const EdgeInsets.only(left: 15.0, right: 10.0),
                  child: Divider(
                    color: Colors.black,
                    height: 50,
                  )),
            ),
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _googleLogin,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: kPrimaryColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/icons8-google.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              GestureDetector(
                onTap: _fbLogin,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                      color: kPrimaryColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  //todo: svg images not showing
                  child: SvgPicture.asset(
                    'assets/icons/icons8-facebook-f.svg',
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logicClass = getIt<LoginPageLogic>();
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: logicClass.shouldShowSignUp,
        child: Text('Don\'t have an account? Sign up.'),
        style: TextButton.styleFrom(
          primary: Colors.grey[800],
        ),
      ),
    );
  }
}
