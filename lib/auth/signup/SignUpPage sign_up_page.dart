
import 'package:flutter/material.dart';
import 'package:food_education_app/auth/signup/signup_page_logic.dart';
import 'package:food_education_app/auth/auth_service.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/services/service_locator.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback shouldShowLogin;
  final AuthService authService;

  SignUpPage({Key key, this.shouldShowLogin, @required this.authService})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePW = true;
  bool _obscureConfirmPW = true;
  bool _loading = false;

  void _setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold SingleChildScrollView
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor)))
          : SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: SingleChildScrollView(
                  child: Column(children: [
                    Image.asset("assets/images/foodcheck_app_logo_auth.png"),
                    Text("Be Our Member",
                      style: TextStyle(
                        fontSize: 30.0
                      ),
                    ),
                    // Sign Up Form
                    _signUpForm(),
                    // Goto login Button
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: TextButton(
                          onPressed: widget.shouldShowLogin,
                          child: Text('Already have an account? Login.'),
                          style: TextButton.styleFrom(
                            primary: Colors.grey[800],
                          )),
                    )
                  ])
              )
      ),
    );
  }

  void _togglePW() {
    setState(() {
      _obscurePW = !_obscurePW;
    });
  }

  void _toggleConfirmPW() {
    setState(() {
      _obscureConfirmPW = !_obscureConfirmPW;
    });
  }

  Widget _signUpForm() {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FormField(
            TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _decoration(
                    Icon(
                      Icons.mail,
                      color: kPrimaryColor,
                    ),
                    'Email',
                    null),
                focusNode: _emailFocus,
                onFieldSubmitted: (term) {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Email';
                  } else if (value.contains(" ")) {
                    return 'Should not contain space';
                  }
                  return null;
                }),
          ),

          FormField(
            TextFormField(
              controller: _passwordController,
              decoration: _decoration(
                  Icon(
                    Icons.lock_open,
                    color: kPrimaryColor,
                  ),
                  'Password',
                  InkWell(
                      onTap: _togglePW,
                      child: Icon(_obscurePW
                          ? Icons.visibility
                          : Icons.visibility_off))),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscurePW,
              focusNode: _passwordFocus,
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_confirmPasswordFocus);
              },
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your Password';
                } else if (value.length < 8) {
                  return 'Use 8 or more characters';
                } else if (value.contains(" ")) {
                  return 'Should not contain space';
                } else if (!checkUserPW()) {
                  return 'Use a mix of letters & numbers'; //& symbols
                }
                return null;
              },
            ),
          ),

          FormField(
            TextFormField(
                controller: _confirmPasswordController,
                decoration: _decoration(
                    Icon(Icons.check_box_outline_blank,
                        color: Colors.transparent),
                    'Confirm Password',
                    InkWell(
                        onTap: _toggleConfirmPW,
                        child: Icon(_obscureConfirmPW
                            ? Icons.visibility
                            : Icons.visibility_off))),
                keyboardType: TextInputType.visiblePassword,
                obscureText: _obscureConfirmPW,
                focusNode: _confirmPasswordFocus,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter your Confirm Password';
                  } else if (value.contains(" ")) {
                    return 'Should not contain space';
                  } else if (_passwordController.text.trim() != value.trim()) {
                    return "Those passwords didn't match. Try again.";
                  }
                  return null;
                }),
          ),

          // Sign Up Button
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(29),
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    //_signUp();
                    final signupLogic = getIt<SignUpPageLogic>();
                    signupLogic.signUp(_emailController.text.trim(), _passwordController.text.trim()); //
                  }
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  InputDecoration _decoration(Icon icon, String hintText, InkWell inkWellData) {
    return InputDecoration(
      icon: icon,
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
      suffix: inkWellData,
    );
  }

  Container FormField(TextFormField formField) {
    Size size = MediaQuery.of(context).size;
    return Container(
        decoration: BoxDecoration(
          color: kPrimaryColor.withAlpha(100),
          borderRadius: BorderRadius.circular(29.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: size.width * 0.9,
        child: formField);
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

  bool checkUserPW() {
    final password = _passwordController.text.trim();
    String pattern = r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$'; // letters + digits
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(password);
  }

}
