import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';


enum AuthFlowStatus {
  login,
  signUp,
  verificationEmail,
  verificationPhone,
  verified,
  session,
  resetPW,
  newUser,
  foodEducation
}

class AuthState {
  final AuthFlowStatus authFlowStatus;

  AuthState({this.authFlowStatus});
}

class AuthService {
  final authStateController = StreamController<AuthState>();

  void showFoodEducation(){
    final state = AuthState(authFlowStatus: AuthFlowStatus.foodEducation);
    authStateController.add(state);
  }

  void showSignUp() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.signUp);
    authStateController.add(state);
  }

  void showLogin() {
    final state = AuthState(authFlowStatus: AuthFlowStatus.login);
    authStateController.add(state);
  }

  void showForgotPW(){
    final state = AuthState(authFlowStatus: AuthFlowStatus.resetPW);
    authStateController.add(state);
  }

  void showNewUserProfile(){
    final state = AuthState(authFlowStatus: AuthFlowStatus.newUser);
    authStateController.add(state);
  }

  void loginWithCredentials() async {
     final state = AuthState(authFlowStatus: AuthFlowStatus.session);
        authStateController.add(state);
  }

  void signUpWithCredentials() async {
    final state = AuthState(authFlowStatus: AuthFlowStatus.verificationEmail);
    authStateController.add(state);
    /*
    User user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('userprofile')
        .doc(user.uid)
        .set({'done': false
    }).then((userInfoValue) {
    });

    if (!user.emailVerified) {
      var actionCodeSettings = ActionCodeSettings(
        url: 'https://fyptest1.page.link/verifyemail/?email=${user.email}',
        dynamicLinkDomain: "fyptest1.page.link",
        androidPackageName: "com.example.fyp_firebase_login",
        androidInstallApp: true,
        handleCodeInApp: true,
        iOSBundleId: "com.example.fyp_firebase_login"
      );

      await user.sendEmailVerification(actionCodeSettings);

      final state = AuthState(authFlowStatus: AuthFlowStatus.verificationEmail);
      authStateController.add(state);

    } else {
      print('signUpWithCredentials - ERROR');
      Fluttertoast.showToast(
          msg: "Error.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }

     */
  }

  //  todo: Sam remark remove
  void verifyCodeViaPhoneNum(String verificationCode) async {
    User user = FirebaseAuth.instance.currentUser;
    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  void logOut() async{
    try {
      await FirebaseAuth.instance.signOut();
      GoogleSignIn().signOut();
      GoogleSignIn().disconnect();
      FacebookAuth.instance.logOut();
      showLogin();
    } catch (authError) {
      print('Could not log out - ${authError.cause}');
    }
  }

  void checkAuthStatus() async {

    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();

      final FirebaseAuth _auth = FirebaseAuth.instance;

      // check if the user has an active session (FB token expire or not?)
      final accessToken = await FacebookAuth.instance.accessToken;

      if(_auth.currentUser == null || accessToken == null){
       // await _auth.signOut();
        final state = AuthState(authFlowStatus: AuthFlowStatus.login);
        authStateController.add(state);
        print('User is currently signed out!');

      } else if(_auth.currentUser.emailVerified){

        bool completedUserProfile = false;
        final User user = _auth.currentUser;

        CollectionReference userprofile =
        FirebaseFirestore.instance.collection('userprofile');

        DocumentReference documentReference = userprofile.doc(user.uid);
        await documentReference.get().then((snapshot){
          completedUserProfile = snapshot.get('done');

          if(completedUserProfile) {
            print('User is signed in! ' + _auth.currentUser.displayName);
            final state = AuthState(authFlowStatus: AuthFlowStatus.session);
            authStateController.add(state);
          } else{
            final state = AuthState(authFlowStatus: AuthFlowStatus.newUser);
            authStateController.add(state);
          }
        });

      } else {
        await FirebaseAuth.instance.signOut();
        GoogleSignIn().signOut();
        GoogleSignIn().disconnect();
        FacebookAuth.instance.logOut();
        final state = AuthState(authFlowStatus: AuthFlowStatus.login);
        authStateController.add(state);
        print('User is currently signed out!');
      }

    } catch(e) {
      // Set `_error` state to true if Firebase initialization fails
      print(e);
    }
  }

  void initDynamicLinks() async {
    // This is called when app comes from background
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          print('We have a dynamic link :');
          print(dynamicLink.toString());

          final Uri deepLink = dynamicLink
              ?.link; //dynamicLink!=null?dynamicLink.link : null

          if (deepLink != null) {
            print("1. Here's the deep link URL:\n" + deepLink.toString());
            String code = deepLink.queryParameters['mode'].toString();
            print("code" + code);
            if (code == "verifyEmail") {
              print('verifyemail');
              logOut();
              Fluttertoast.showToast(
                  msg: "Email Address Verified",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  // also possible "TOP" and "CENTER"
                  backgroundColor: Colors.green,
                  textColor: Colors.white);
            } else {
              showLogin();
            }
          }
        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    // This is called when app comes from background
    final PendingDynamicLinkData data = await FirebaseDynamicLinks.instance
        .getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      String code = deepLink.queryParameters['mode'].toString();
      if (code == "verifyEmail") {
        logOut();
        Fluttertoast.showToast(
            msg: "Email Address Verified",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            // also possible "TOP" and "CENTER"
            backgroundColor: Colors.green,
            textColor: Colors.white);
      } else {
        showLogin();
      }
    }
  }
}


