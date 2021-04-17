import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../auth_service.dart';

typedef ShowDialogCallback = void Function(String title, String content);

class LoginPageLogic {
  final loadingNotifier = ValueNotifier<bool>(false);
  bool _completedUserProfile = false;
  AuthService _authService;
  ShowDialogCallback _onEmailLoginError;

  void setup(AuthService authService, ShowDialogCallback onEmailLoginError) {
    _authService = authService;
    _onEmailLoginError = onEmailLoginError;
  }

  void fbLogin() async {
    try {
      loadingNotifier.value = true;

      // Trigger the sign-in
      final accessToken = await FacebookAuth.instance.login();
     // accessToken.accessToken;
      // Create a credential from the access token
      final OAuthCredential credential = FacebookAuthProvider.credential(
          accessToken.accessToken.token);
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
        _authService.loginWithCredentials();
      } else {
        _authService.showNewUserProfile();
      }
    } on FacebookAuthErrorCode catch (fbAuthError) {
      // _showErrorDialog("Facebook Error",
      //     "Error code: ${fbAuthError.errorCode}\nError message: ${fbAuthError.message}");
    } on FirebaseAuthException catch (authError) {
      // _showErrorDialog("Login Error",
      //     "Error code: ${authError.code}\nError message: ${authError.message}");
    } finally {
      loadingNotifier.value = false;
    }
  }

  void googleLogin() async {
    try {
      loadingNotifier.value = true;

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
        _authService.loginWithCredentials();
      } else {
        _authService.showNewUserProfile();
      }
    } on FirebaseAuthException catch (authError) {
      // _showErrorDialog("Login Error",
      //     "Error code: ${authError.code}\nError message: ${authError.message}");
    } finally {
      loadingNotifier.value = false;
    }
  }

  void emailLogin(String email, String password) async {
    try {
      loadingNotifier.value = true;

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
          _authService.loginWithCredentials();
        } else {
          _authService.showNewUserProfile();
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
        _onEmailLoginError(
            "Email Verification", "Please check your inbox and verify email");

        await FirebaseAuth.instance.signOut();
      }
    } on FirebaseAuthException catch (authError) {
      if (authError.code == 'user-not-found' ||
          authError.code == 'wrong-password') {
        _onEmailLoginError("Login Failed", "Invalid email or password.");
      } else {
        _onEmailLoginError("Unknown Error",
            "Error code: ${authError.code}\nError message: ${authError.message}");
      }
    } finally {
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
