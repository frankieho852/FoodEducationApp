import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fyp_firebase_login/constants.dart';
import 'package:fyp_firebase_login/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback loginWithCredentials;
  final VoidCallback shouldShowSignUp;
  final VoidCallback showForgotPW;
  final VoidCallback showNewUserProfile;

  LoginPage(
      {Key key,
      this.loginWithCredentials,
      this.shouldShowSignUp,
      this.showForgotPW,
      this.showNewUserProfile})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

//  todo: Login page UI
// todo: Support email & FB & google now. If you want to support phone number, you can design related UI to login page and sign up page

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _completedUserProfile = false;
  final _formKeyLogin = GlobalKey<FormState>();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SafeArea(
              child: Stack(children: [
              // Login Form
              _loginForm(),
              // Sign Up Button
              Container(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: widget.shouldShowSignUp,
                  child: Text('Don\'t have an account? Sign up.'),
                  // RichText(
                  //   text:
                  //
                  //   TextSpan(
                  //     text: 'Don\'t have an account? ',
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //         text: 'Sign up.',
                  //         style: TextStyle(fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  style: TextButton.styleFrom(
                    primary: Colors.grey[800],
                  ),
                ),
              ),
            ])),
    );
  }

  Widget _loginForm() {
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
          // FacebookSignInButton(
          //     onPressed: _fbLogin, splashColor: Colors.white, borderRadius: 10),
          // SizedBox(height: 12),
          // GoogleSignInButton(
          //     onPressed: _googleLogin,
          //     darkMode: true,
          //     splashColor: Colors.white,
          //     borderRadius: 10),

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

  void _fbLogin() async {
    try {
      setState(() {
        _loading = true;
      });

      // Trigger the sign-in flow
      final AccessToken accessToken = await FacebookAuth.instance.login();

      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(
        accessToken.token,
      );
      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User _user = FirebaseAuth.instance.currentUser;

      CollectionReference userprofile =
          FirebaseFirestore.instance.collection('userprofile');
      DocumentReference documentReference = userprofile.doc(_user.uid);

      try {
        await documentReference.get().then((snapshot) {
          _completedUserProfile = snapshot.get('done');
        });
      } on StateError catch (e) {
        //"done - not exist"
        // set done
        FirebaseFirestore.instance
            .collection('userprofile')
            .doc(_user.uid)
            .set({'done': false});
      }

      // Google sign-in: email auto verified
      if (_completedUserProfile) {
        widget.loginWithCredentials();
      } else {
        widget.showNewUserProfile();
      }
    } on FacebookAuthException catch (fbAuthError) {
      _showErrorDialog("Facebook Error",
          "Error code: ${fbAuthError.errorCode}\nError message: ${fbAuthError.message}");
    } on FirebaseAuthException catch (authError) {
      _showErrorDialog("Login Error",
          "Error code: ${authError.code}\nError message: ${authError.message}");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _googleLogin() async {
    try {
      setState(() {
        _loading = true;
      });

      // Trigger the authentication flow
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final GoogleAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);

      final User _user = FirebaseAuth.instance.currentUser;

      CollectionReference userprofile =
          FirebaseFirestore.instance.collection('userprofile');
      DocumentReference documentReference = userprofile.doc(_user.uid);

      try {
        await documentReference.get().then((snapshot) {
          _completedUserProfile = snapshot.get('done');
        });
      } on StateError catch (e) {
        //"done - not exist"
        // set done
        FirebaseFirestore.instance
            .collection('userprofile')
            .doc(_user.uid)
            .set({'done': false});
      }

      // Google sign-in: email auto verified
      if (_completedUserProfile) {
        widget.loginWithCredentials();
      } else {
        widget.showNewUserProfile();
      }
    } on FirebaseAuthException catch (authError) {
      _showErrorDialog("Login Error",
          "Error code: ${authError.code}\nError message: ${authError.message}");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _emailLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      setState(() {
        _loading = true;
      });

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User _user = FirebaseAuth.instance.currentUser;
      if (_user.emailVerified) {
        CollectionReference userprofile =
            FirebaseFirestore.instance.collection('userprofile');

        DocumentReference documentReference = userprofile.doc(_user.uid);
        await documentReference.get().then((snapshot) {
          _completedUserProfile = snapshot.get('done');
        });

        if (_completedUserProfile) {
          widget.loginWithCredentials();
        } else {
          widget.showNewUserProfile();
        }
      } else {
        var actionCodeSettings = ActionCodeSettings(
            url: 'https://fyptest1.page.link/verifyemail/?email=${_user.email}',
            dynamicLinkDomain: "fyptest1.page.link",
            androidPackageName: "com.example.fyp_firebase_login",
            androidInstallApp: true,
            handleCodeInApp: false,
            iOSBundleId: "com.example.fyp_firebase_login");
        //await _user.sendEmailVerification();

        await _user.sendEmailVerification(actionCodeSettings);
        _showErrorDialog(
            "Email Verification", "Please check your inbox and verify email");

        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (authError) {
      if (authError.code == 'user-not-found' ||
          authError.code == 'wrong-password') {
        _showErrorDialog("Login Failed", "Invalid email or password.");
      } else {
        _showErrorDialog("Unknown Error",
            "Error code: ${authError.code}\nError message: ${authError.message}");
      }
    } finally {
      setState(() {
        _emailController.clear();
        _passwordController.clear();
        _loading = false;
      });
    }
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
