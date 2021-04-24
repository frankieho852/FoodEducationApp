
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/auth/components/login_form.dart';
import 'package:food_education_app/constants.dart';

class forgotPW extends StatefulWidget {

  final VoidCallback backButton;

  forgotPW({Key key, this.backButton})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _forgotPWState();
}

//  todo: forgot Password UI
class _forgotPWState extends State<forgotPW> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _formKeyForgotPW = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        leading: new IconButton(
          color: Colors.grey[700],
          icon: new Icon(Icons.arrow_back),
          splashRadius: 24,
          onPressed: widget.backButton,
        ),
      ),
      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: _forgotPWForm(),
      ),
    );
  }

  Widget _forgotPWForm() {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKeyForgotPW,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Forgot your password?",
              style: TextStyle(
                fontSize: 20.0
              ),
            ),
            //SizedBox();
            Text("Don't worry! Just fill in your email and",
              style: TextStyle(
                  fontSize: 15.0
              ),
            ),Text("we'll send you a link to reset your password.",
              style: TextStyle(
                  fontSize: 15.0
              ),
            ),

   //     Size size = MediaQuery.of(context).size;
            EmailFormField(emailController: _emailController),

            // Verify Button
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
                    if (_formKeyForgotPW.currentState.validate()) {
                      _resetPW();
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ));
  }



  void _resetPW() async {
    final email = _emailController.text.trim();
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

    var actionCodeSettings = ActionCodeSettings(
        url: 'https://foodeducation.page.link/resetpw/',
        dynamicLinkDomain: "foodeducation.page.link",
        androidPackageName: "com.example.food_education_app",
        androidInstallApp: true,
        handleCodeInApp: true,
        iOSBundleId: "com.example.food_education_app");

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email, actionCodeSettings: actionCodeSettings);

      _showErrorDialog('Reset password', "Please check your inbox and follow the instructions.");

    } on FirebaseAuthException catch (authError) {
      if (authError.code == 'user-not-found') {
        _showErrorDialog('Email Issue', "This email is not registered.");

      } else {
        _showErrorDialog("Error", "Error code: ${authError.code}");
      }
    } finally{
      _emailController.clear();
    }
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

/*
  InputDecoration _decoration(Icon icon, String hintText) {
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
    );
  }

 */

}