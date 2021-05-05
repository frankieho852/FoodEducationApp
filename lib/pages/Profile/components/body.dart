import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/auth/resetPW/resetPW.dart';
import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatefulWidget {

  final VoidCallback shouldLogOut;

  const Body({Key key, this.shouldLogOut}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: checkProvider()? cannotChangePW():canChangePW(),
    );
  }


  Widget canChangePW(){
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),

        ProfileMenu(
          text: "Reset Password",
          icon: "assets/icons/rotation-lock.svg",
          press: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => resetPW(shouldLogOut:widget.shouldLogOut
                    )));
          },
        ),

        ProfileMenu(
          text: "Log Out",
          icon: "assets/icons/Log out.svg",
          press: () {
            widget.shouldLogOut();
          },
        ),
      ],
    );
  }

  Widget cannotChangePW(){
    return Column(
      children: [
        ProfilePic(),
        SizedBox(height: 20),
        ProfileMenu(
          text: "My Account",
          icon: "assets/icons/User Icon.svg",
          press: () => {},
        ),

        ProfileMenu(
          text: "Settings",
          icon: "assets/icons/Settings.svg",
          press: () {},
        ),
        ProfileMenu(
          text: "Help Center",
          icon: "assets/icons/Question mark.svg",
          press: () {},
        ),
        ProfileMenu(
          text: "Log Out",
          icon: "assets/icons/Log out.svg",
          press: () {
            widget.shouldLogOut();
          },
        ),
      ],
    );
  }

  bool checkProvider(){
    final User _user = FirebaseAuth.instance.currentUser;
    for(UserInfo providerData in _user.providerData){

      if(providerData.providerId == "facebook.com" ||providerData.providerId == "google.com"){
        print("logged with Facebook or google");
        return true;
      }
      return false;
    }
  }

}
