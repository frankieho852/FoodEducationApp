import 'package:flutter/material.dart';
import 'package:food_education_app/services/service_locator.dart';

import '../login_page_logic.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logicClass = getIt<LoginPageLogic>();
    return Container(
      alignment: Alignment.bottomCenter,
      child: TextButton(
        onPressed: logicClass.shouldShowSignUp,
        child: Text('Don\'t have an account? Sign up.'),
        style: TextButton.styleFrom(
          primary: Colors.grey[800],
        ),
      ),
    );
  }
}
