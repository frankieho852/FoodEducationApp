
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_education_app/auth/auth_service.dart';

typedef ShowDialogCallback = void Function(String title, String content);
typedef ShowLoading = void Function(bool loading);

class SignUpPageLogic {
  final loadingNotifier = ValueNotifier<bool>(false);
  ShowLoading _setLoading;
  AuthService _authService;
  ShowDialogCallback _onSignupError;

  void setup(AuthService authService, ShowDialogCallback onSignupError, ShowLoading loading) {
    _authService = authService;
    _onSignupError = onSignupError;
    _setLoading = loading;
  }

  void signUp(String email, String password) async {

    loadingNotifier.value = true;
    _setLoading(true);

    try {
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
            iOSBundleId: "com.example.food_education_app");

        await _user.sendEmailVerification(actionCodeSettings);

        _authService.signUpWithCredentials();

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
        _onSignupError('Weak Password', "The password provided is too weak.");
      } else if (authError.code == 'email-already-in-use') {
        _onSignupError('Email already in use!',
            "The account already exists for that email.");
        print('The account already exists for that email.');
      } else if (authError.code == 'invalid-email') {
        _onSignupError("Invalid email", "Please enter correct email");
      } else {
        _onSignupError('Unknown Error', "Error code: " + authError.code);
      }
    } catch (e) {
      print('Failed to sign up - ' + e);
    } finally {
      _setLoading(false);
    }


  }

}
