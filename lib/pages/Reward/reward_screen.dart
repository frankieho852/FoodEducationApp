import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:food_education_app/constants.dart';

class RewardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reward"),
      ),
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
