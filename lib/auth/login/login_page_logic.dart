import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:food_education_app/auth_service.dart';
import 'package:google_sign_in/google_sign_in.dart';


typedef ShowDialogCallback = void Function(String title, String content);
typedef ShowLoading = void Function(bool loading);

class LoginPageLogic {
  final loadingNotifier = ValueNotifier<bool>(false);
  bool _completedUserProfile = false;
  AuthService _authService;
  ShowDialogCallback _onLoginError;
  ShowLoading _setLoading;

  void setup(AuthService authService, ShowDialogCallback onLoginError, ShowLoading loading) {
    _authService = authService;
    _onLoginError = onLoginError;
    _setLoading = loading;
  }

  void fbLogin() async {
    loadingNotifier.value = true;
    _setLoading(true);
    try {
      // Trigger the sign-in
      final LoginResult result = await FacebookAuth.instance.login();

      if(result.status == LoginStatus.success){
        // Create a credential from the access token
        final OAuthCredential credential = FacebookAuthProvider.credential(
            result.accessToken.token);

        // Once signed in, return the UserCredential
        await FirebaseAuth.instance.signInWithCredential(credential);

        final User _user = FirebaseAuth.instance.currentUser;

        CollectionReference userprofile =
        FirebaseFirestore.instance.collection('userProfile');
        DocumentReference documentReference = userprofile.doc(_user.uid);

        try {
          await documentReference.get().then((snapshot) {
            _completedUserProfile = snapshot.get('completedProfile');
          });
        } on StateError catch (e) {
          //"done - not exist"
          // set done
          FirebaseFirestore.instance
              .collection('userProfile')
              .doc(_user.uid)
              .set({'completedProfile': false});
        }
        // Google sign-in: email auto verified
        if (_completedUserProfile) {
          _authService.loginWithCredentials();
        } else {
          _authService.showNewUserProfile();
        }
      } else {
        _onLoginError(result.status.toString(), result.message);
      }
    } on FirebaseAuthException catch (authError) {
      _onLoginError("Login Error", "Error code: ${authError.code}\nError message: ${authError.message}");
      // _showErrorDialog("Login Error",
      //     "Error code: ${authError.code}\nError message: ${authError.message}");
    } finally {
      _setLoading(false);
      loadingNotifier.value = false;
    }
  }

  void googleLogin() async {
    loadingNotifier.value = true;
    _setLoading(true);
    try {
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
          FirebaseFirestore.instance.collection('userProfile');
      DocumentReference documentReference = userprofile.doc(_user.uid);

      try {
        await documentReference.get().then((snapshot) {
          _completedUserProfile = snapshot.get('completedProfile');
        });
      } on StateError catch (e) {
        //"done - not exist"
        // set done
        FirebaseFirestore.instance
            .collection('userProfile')
            .doc(_user.uid)
            .set({'completedProfile': false});
      }

      // Google sign-in: email auto verified
      if (_completedUserProfile) {
        _authService.loginWithCredentials();
      } else {
        _authService.showNewUserProfile();
      }
    } on FirebaseAuthException catch (authError) {
      _onLoginError("Login Error", "Error code: ${authError.code}\nError message: ${authError.message}");
      // _showErrorDialog("Login Error",
      //     "Error code: ${authError.code}\nError message: ${authError.message}");
    } finally {
      _setLoading(false);
      loadingNotifier.value = false;
    }
  }

  void emailLogin(String email, String password) async {
    loadingNotifier.value = true;
    _setLoading(true);
    try {

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      final User _user = FirebaseAuth.instance.currentUser;
      if (_user.emailVerified) {
        CollectionReference userprofile =
            FirebaseFirestore.instance.collection('userProfile');

        DocumentReference documentReference = userprofile.doc(_user.uid);
        await documentReference.get().then((snapshot) {
          _completedUserProfile = snapshot.get('completedProfile');
        });

        if (_completedUserProfile) {
          _authService.loginWithCredentials();
        } else {
          _authService.showNewUserProfile();
        }
      } else {
        var actionCodeSettings = ActionCodeSettings(
            url: 'https://foodeducation.page.link/verifyemail/?email=${_user.email}',
            dynamicLinkDomain: "foodeducation.page.link",
            androidPackageName: "com.example.food_education_app",
            androidInstallApp: true,
            handleCodeInApp: false,
            iOSBundleId: "com.example.food_education_app");
        //await _user.sendEmailVerification();

        await _user.sendEmailVerification(actionCodeSettings);
        _onLoginError(
            "Email Verification", "Please check your inbox and verify email");

        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (authError) {
      if (authError.code == 'user-not-found' ||
          authError.code == 'wrong-password') {
        _onLoginError("Login Failed", "Invalid email or password.");
      } else {
        _onLoginError("Unknown Error",
            "Error code: ${authError.code}\nError message: ${authError.message}");
      }
    } finally {
      _setLoading(false);
      loadingNotifier.value = false;
    }
  }

  void showForgetPW() {
    _authService.showForgotPW();
  }

  void shouldShowSignUp() {
    _authService.showSignUp();
  }
}
