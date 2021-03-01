import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';

class DetailResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FoodProduct tempfood = FoodProduct(
        name: "Vita Lemon Tea",
        protein: 1,
        totalFat: 21,
        totalCarbonhydrates: 12,
        energy: 210,
        star: 4.0,
        grade: "assets/images/A-minus.jpg",
        ingredients: ["bad ingredient", "good ingredient"],);
    // need a List <AlternativeProduct> with 2 element to fill in alternativebox
    return Scaffold(
      appBar: buildAppBar(tempfood.name),
      body: Body(product: tempfood),

      //bottomNavigationBar: MyBottomNavBar(),
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