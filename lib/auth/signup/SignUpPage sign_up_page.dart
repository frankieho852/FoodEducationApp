import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_education_app/auth/components/login_form.dart';
import 'package:food_education_app/auth/signup/signup_form.dart';
import 'package:food_education_app/auth/signup/signup_page_logic.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/services/service_locator.dart';

class SignUpPage extends StatefulWidget {
  final VoidCallback didProvideEmail;
  final VoidCallback shouldShowLogin;

  SignUpPage({Key key, this.didProvideEmail, this.shouldShowLogin})
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

  void initState() {
    // TODO: implement initState
    super.initState();
    final signupLogic = getIt<SignUpPageLogic>();
    //signupLogic.setup(widget.authService, _showErrorDialog, _setLoading);
  }

  @override
  Widget build(BuildContext context) {
    //Scaffold SingleChildScrollView
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              minimum: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: SingleChildScrollView(
                  child: Column(children: [
                // Sign Up Form
                _signUpForm(),

                // Login Button
                Container(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                      onPressed: widget.shouldShowLogin,
                      child: Text('Already have an account? Login.'),
                      style: TextButton.styleFrom(
                        primary: Colors.grey[800],
                      )),
                )
              ]))),
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

          TextButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _signUp();
              }
            },
            child: Text('Sign Up'),
          )
        ],
      ),
    );
  }

  bool checkUserPW() {
    final password = _passwordController.text.trim();
    String pattern = r'^(?=.*?[A-Za-z])(?=.*?[0-9]).{8,}$'; // letters + digits
    RegExp regExp = new RegExp(pattern);

    return regExp.hasMatch(password);
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

  void _showDialog(String title, String content) {
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

  void _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      setState(() {
        _loading = true;
      });

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User _user = FirebaseAuth.instance.currentUser;
      FirebaseFirestore.instance
          .collection('userProfile')
          .doc(_user.uid)
          .set({'completedProfile': false}).then((userInfoValue) {});

      if (!_user.emailVerified) {
        var actionCodeSettings = ActionCodeSettings(
            url:
                'https://foodeducation.page.link/verifyemail/?email=${_user.email}',
            dynamicLinkDomain: "foodeducation.page.link",
            androidPackageName: "com.example.food_education_app",
            androidInstallApp: true,
            handleCodeInApp: false,
            iOSBundleId: "com.example.fyp_firebase_login");

        await _user.sendEmailVerification(actionCodeSettings);
        widget.didProvideEmail();
      } else {
        Fluttertoast.showToast(
            msg: "Fail to send email.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.red,
            textColor: Colors.white);
      }
    } on FirebaseAuthException catch (authError) {
      if (authError.code == 'weak-password') {
        // might remove this statement later
        _showDialog('Weak Password', "The password provided is too weak.");
      } else if (authError.code == 'email-already-in-use') {
        _showDialog('Email already in use!',
            "The account already exists for that email.");
        print('The account already exists for that email.');
      } else if (authError.code == 'invalid-email') {
        _showDialog("Invalid email", "Please enter correct email");
      } else {
        _showDialog('Unknown Error', "Error code: " + authError.code);
      }
    } catch (e) {
      print('Failed to sign up - ' + e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
}
