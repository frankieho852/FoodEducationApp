import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerificationPageEmail extends StatefulWidget {

  final VoidCallback backButton;
  final VoidCallback shouldShowLogin;

  VerificationPageEmail(
      {Key key,  this.backButton, this.shouldShowLogin})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}


class _VerificationPageState extends State<VerificationPageEmail> {
  Timer _timer;
  int _timerStart = 60;
  bool _isButtonDisabled;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();
    _isButtonDisabled = true;
    _startTimer();
  }

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
        child: _verificationForm(),
      ),
    );
  }

  Widget _verificationForm() {
    return Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Verification email sent!"),
            Text("Please check your inbox and follow the instructions."),
            Text("Email sent to:"),
            Text(_getEmailAddress()),
            Text("$_timerStart" + " seconds"),

            _buildResendButton(),

            // Verify Button
            FlatButton(
                onPressed: () {
                  widget.shouldShowLogin();
                },
                child: Text("I'm Ready"),
                color: Theme.of(context).accentColor),
          ],
        ));
  }

  String _getEmailAddress(){
    return _auth.currentUser.email;
  }

  void _startTimer(){
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      print('timer 1');
    } else {
      print('timer 2');
      _timerStart = 60;
      _timer = new Timer.periodic(
        const Duration(seconds: 1),
            (Timer timer) => setState(
              () {
            if (_timerStart < 1) {
              timer.cancel();
              _timer = null;
              _isButtonDisabled = false;
            } else {
              _timerStart = _timerStart - 1;
            }
          },
        ),
      );
    }
  }

  Widget _buildResendButton() {
    return new FlatButton(
      textColor: _isButtonDisabled ? Colors.grey:Colors.black,
      child: Text('Resend'),
      onPressed: _isButtonDisabled ? null : _resendCode,
      );
  }

  void _resendCode() async{
    User user = FirebaseAuth.instance.currentUser;
    setState(() {
      _isButtonDisabled = true;
      _startTimer();
    });

    if (!user.emailVerified) {

      try {
        String emailAuth = user.email;

        var actionCodeSettings = ActionCodeSettings(
          url: 'https://fyptest1.page.link/verifyemail?email=${emailAuth}',
          dynamicLinkDomain: "fyptest1.page.link",
          androidPackageName: "com.example.fyp_firebase_login",
          androidInstallApp: true,
          handleCodeInApp: true,
          iOSBundleId: "com.example.fyp_firebase_login",
        );

        await user.sendEmailVerification(actionCodeSettings);

        Fluttertoast.showToast(
            msg: "Email Sent Again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            // also possible "TOP" and "CENTER"
            backgroundColor: Colors.green,
            textColor: Colors.white);

      } catch(e){

        showDialog<void>(
            context: context,
            barrierDismissible: false, // user must tap button!
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Error"),
                content: Text(e.toString()),
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

    } else{
      final snackbar = SnackBar(
        content: Text('Your email address is verified'),
        action: SnackBarAction(
          label: 'Login',
          onPressed:() {
            widget.shouldShowLogin();
          }
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  void dispose(){
    super.dispose();
    _timer.cancel();
  }
}

