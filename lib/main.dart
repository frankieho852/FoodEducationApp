import 'package:flutter/material.dart';
import 'package:food_education_app/pages/home/home_screen.dart';

// todo: is the pages.home file structure correct?
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(),
      },
    );
  }
}
