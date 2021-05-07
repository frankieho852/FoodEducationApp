import 'package:flutter/material.dart';
import 'package:food_education_app/auth/auth_service.dart';
import 'package:food_education_app/pages/home/home_screen.dart';

import 'components/bottom_nav_bar.dart';

// todo: is the pages.home file structure correct?
class FoodEducationMain extends StatefulWidget {
  //final AuthService authService;
  final VoidCallback shouldLogOut;

  const FoodEducationMain({Key key,this.shouldLogOut}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FoodEducationMainState();
}

class _FoodEducationMainState extends State<FoodEducationMain> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "FoodEdu App",
      theme: ThemeData(
        primaryColor: Color(0xFF00A299),
        //textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: 'bottom_nav_bar',
      routes: {
        'home': (context) => HomeScreen(),
        'bottom_nav_bar': (context) => BottomNavBar(shouldLogOut: widget.shouldLogOut),
      },
    );

  }
}
