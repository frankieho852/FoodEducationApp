import 'package:flutter/material.dart';
import 'package:food_education_app/dailyintake.dart';
import 'package:food_education_app/foodproduct.dart';
class Nutritionbar extends StatelessWidget {
  const Nutritionbar({
    Key key,
    @required this.daily,
    @required this.size,
    @required this.product,
  }) : super(key: key);

  final DailyIntake daily;
  final Size size;
  final FoodProduct product;
  @override
  Widget build(BuildContext context) {
    double recommendintake=this.product.energy;
    return Container(
      height: size.height*0.07,
        color: Colors.green,
        child: Row(
          children: [
            Text(daily.nutrient),
            Text(recommendintake.toString())
          ],
        ));
  }
}