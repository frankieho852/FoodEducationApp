import 'package:flutter/material.dart';

// unused for now
class VerificationPagePhone extends StatefulWidget {
  final ValueChanged<String> didProvideVerificationCode;
  final VoidCallback backButton;

  VerificationPagePhone(
      {Key key, this.didProvideVerificationCode,  this.backButton})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPagePhone> {
  final _verificationCodeController = TextEditingController();
  final _formCodeKey = GlobalKey<FormState>();

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
        key: _formCodeKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Verification Code TextField
            TextFormField(
              controller: _verificationCodeController,
              decoration: InputDecoration(
                  icon: Icon(Icons.confirmation_number),
                  labelText: 'Verification code'),
              validator: (value) {
                if (value.isEmpty) {
                  print('Please enter the verification code');
                  return 'Please enter the verification code';
                } else if (false) {
                  //(widget.reTryVerifyCode == true
                  return 'This verification code is invalid';
                }
                return null;
              },
            ),

            FlatButton(
              onPressed: _resendCode,
              child: Text('Resend code?'),
            ),

            // Verify Button
            FlatButton(
                onPressed: widget.backButton,
                child: Text('Back'),
                color: Theme.of(context).accentColor),
          ],
        ));
  }

  void _resendCode(){

  }
}
