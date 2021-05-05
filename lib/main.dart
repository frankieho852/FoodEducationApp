import 'package:flutter/material.dart';
import 'package:food_education_app/auth/forgotPW/forgotPW.dart';
import 'package:food_education_app/auth/login/login_page.dart';
import 'package:food_education_app/auth/signup/SignUpPage%20sign_up_page.dart';
import 'package:food_education_app/constants.dart';

import 'package:food_education_app/services/service_locator.dart';

import 'auth/Verification_page_email.dart';
import 'tempRubbishBin/Verification_page_succeed.dart';
import 'auth/auth_service.dart';
import 'foodeducationMain.dart';

import 'auth/new_userprofile.dart';

void main() {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _authService = getIt<AuthService>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _authService.initDynamicLinks();
    _authService.checkAuthStatus();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FoodCheck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Color(0xFF00A299),visualDensity: VisualDensity.adaptivePlatformDensity),
      home: StreamBuilder<AuthState>(
          stream: _authService.authStateController.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Navigator(
                pages: [
                  // Show Login Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.login)
                    MaterialPage(
                      child: LoginPage(authService: _authService),
                    ),

                  // Show Sign Up Page
                  if (snapshot.data.authFlowStatus == AuthFlowStatus.signUp)
                    MaterialPage(
                        child: SignUpPage(authService: _authService,
                          shouldShowLogin: _authService.showLogin,
                        )),

                  if (snapshot.data.authFlowStatus ==
                      AuthFlowStatus.verificationEmail)
                    MaterialPage(
                        child: VerificationPageEmail(
                            backButton: _authService.showSignUp,
                            shouldShowLogin: _authService.showLogin)),

                  if (snapshot.data.authFlowStatus == AuthFlowStatus.verified)
                    MaterialPage(
                        child: VerificationPageSucceed(
                          shouldShowLogin: _authService.showLogin,
                        )),

                  if (snapshot.data.authFlowStatus == AuthFlowStatus.resetPW)
                    MaterialPage(
                        child: forgotPW(backButton: _authService.showLogin)),

                  if (snapshot.data.authFlowStatus == AuthFlowStatus.newUser)
                    MaterialPage(
                        child: newUserProfilePage(
                            logOutBtn: _authService.logOut,
                            showFoodEducation:
                            _authService.loginWithCredentials)),

                  if (snapshot.data.authFlowStatus == AuthFlowStatus.session)
                    MaterialPage(child:FoodEducationMain(shouldLogOut: _authService.logOut)
                        ), //authService: _authService child:FoodEducationMain()
                ],
                onPopPage: (route, result) => route.didPop(result),
              );
            } else {
              return  Scaffold(
                  body: Center(
                      child: CircularProgressIndicator(
                          valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor)))
              );
            }
          }),
    );
  }
}
