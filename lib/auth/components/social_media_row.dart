import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_education_app/auth/login/login_page_logic.dart';
import 'package:food_education_app/constants.dart';

import 'package:food_education_app/services/service_locator.dart';



class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginPageLogic = getIt<LoginPageLogic>();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: loginPageLogic.googleLogin,
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
          onTap: loginPageLogic.fbLogin,
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
    );
  }
}
