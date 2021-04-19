
class SignUpPageLogic {
  //final loadingNotifier = ValueNotifier<bool>(false);
  //bool _completedUserProfile = false;
  //AuthService _authService;
 // ShowDialogCallback _onLoginError;

 // void setup(AuthService authService, ShowDialogCallback onLoginError) {
   // _authService = authService;
    //_onLoginError = onLoginError;
  //}

  /*
  void _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      setState(() {
        _loading = true;
      });

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
            iOSBundleId: "com.example.fyp_firebase_login");

        await _user.sendEmailVerification(actionCodeSettings);
        widget.didProvideEmail();
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
        _showDialog('Weak Password', "The password provided is too weak.");
      } else if (authError.code == 'email-already-in-use') {
        _showDialog('Email already in use!',
            "The account already exists for that email.");
        print('The account already exists for that email.');
      } else if (authError.code == 'invalid-email') {
        _showDialog("Invalid email", "Please enter correct email");
      } else {
        _showDialog('Unknown Error', "Error code: " + authError.code);
      }
    } catch (e) {
      print('Failed to sign up - ' + e);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }
   */



}
