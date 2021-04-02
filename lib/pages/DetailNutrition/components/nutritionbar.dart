import 'package:flutter/material.dart';
import 'package:food_education_app/dailyintake.dart';

class Nutritionbar extends StatelessWidget {
  const Nutritionbar({
    Key key,
    @required this.daily,
    @required this.size,
  }) : super(key: key);

  final DailyIntake daily;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height*0.07,
        color: Colors.green,
        child: Text(daily.nutrient));
  }
}