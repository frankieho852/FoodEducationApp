import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/auth/components/goto_sign_up_button.dart';
import 'package:food_education_app/auth/components/login_button.dart';
import 'package:food_education_app/auth/components/login_form.dart';
import 'package:food_education_app/auth/components/social_media_row.dart';
import 'package:food_education_app/auth/login/login_page_logic.dart';
import 'package:food_education_app/auth/auth_service.dart';
import 'package:food_education_app/services/service_locator.dart';

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
    loginLogic.setup(widget.authService, _showErrorDialog, _setLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading ? Center(child: CircularProgressIndicator()) : LoginForm(),
    );
  }

  void _setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

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

class LoginForm extends StatefulWidget {
  LoginForm({
    Key key,
    bool loading,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKeyLogin = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
            child: SingleChildScrollView(

                child: Column(children: [
                  Image.asset("assets/images/foodcheck_app_logo_auth.png"),

                  // Login Form
                  _loginForm(),
                  // Sign Up Button
                  GoToSignUpButton(),
                ])))
        );

  }

  Widget _loginForm() {
    return Form(
      key: _formKeyLogin,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          EmailFormField(
            emailController: _emailController,
          ),
          PasswordFormField(passwordController: _passwordController),
          LoginButton(
              formKeyLogin: _formKeyLogin,
              emailController: _emailController,
              passwordController: _passwordController),
          TextButton(
              onPressed: () {
                final loginPageLogic = getIt<LoginPageLogic>();
                loginPageLogic.showForgetPW();
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
          SocialMediaRow(),
        ],
      ),
    );
  }
}
