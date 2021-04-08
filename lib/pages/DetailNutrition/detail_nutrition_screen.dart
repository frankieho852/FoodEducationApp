import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailNutrition/components/body.dart';
import 'package:food_education_app/dailyintake.dart';
class DetailedNutrition extends StatelessWidget {
  final FoodProduct product;
  final List<DailyIntake> daily;
  final Size size;
  DetailedNutrition({Key key, @required this.size,
  @required this.product,
  @required this.daily,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(product.name),
      body: Body(product: product,daily: daily,),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(
        '$title',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}