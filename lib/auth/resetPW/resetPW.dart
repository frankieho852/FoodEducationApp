
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/auth/components/login_form.dart';
import 'package:food_education_app/constants.dart';

class resetPW extends StatefulWidget {

  final VoidCallback shouldLogOut;

  resetPW({Key key, this.shouldLogOut})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _resetPWState();
}

class _resetPWState extends State<resetPW> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();

  final _formKeyResetPW = GlobalKey<FormState>();

  bool _obscurePW = true;
  bool _obscureConfirmPW = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator(valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor)))
          : SafeArea(
          minimum: EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: SingleChildScrollView(
              child: Column(children: [
                // Sign Up Form
                _resetPWForm(),
                // Goto login Button
              ])
          )
      ),
    );

    /*
    return Scaffold(

      body: SafeArea(
        minimum: EdgeInsets.symmetric(horizontal: 40),
        child: _resetPWForm(),
      ),
    );

     */
  }

  void _setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  Widget _resetPWForm() {
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKeyResetPW,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Reset your password",
              style: TextStyle(
                  fontSize: 20.0
              ),
            ),
            //SizedBox();
            /*
            Text("Don't worry! Just fill in your email and",
              style: TextStyle(
                  fontSize: 15.0
              ),
            ),Text("we'll send you a link to reset your password.",
              style: TextStyle(
                  fontSize: 15.0
              ),
            ),

             */

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
                    if (_formKeyResetPW.currentState.validate()) {
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

  void _resetPW() async {
    _setLoading(true);
    final password = _passwordController.text.trim();
    final User _user = FirebaseAuth.instance.currentUser;

    try {
      _user.updatePassword(password);
      widget.shouldLogOut();
    } on FirebaseAuthException catch (authError) {
      if (authError.code == 'weak-password') {
        _showErrorDialog('Password Issue', "The password is not strong enough");

      } else if(authError.code == 'requires-recent-login'){
        _showErrorDialog('Security Issue', "Your last sign-in time does not meet the security threshold. You can re-login.");
      }else {
        _showErrorDialog("Error", "Error code: ${authError.code}");
      }
    } finally{
      _passwordController.clear();
      _confirmPasswordController.clear();
      _setLoading(false);
    }
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