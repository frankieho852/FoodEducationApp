import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailScore/components/body.dart';
import 'package:food_education_app/calculategrade.dart';

class DetailedScore extends StatelessWidget {
  final FoodProduct product;
  final ScoreArray scoreArray;
  DetailedScore({Key key, @required this.product, @required this.scoreArray,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(product.name),
      body: Body(product: product,scoreArray:scoreArray),
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
