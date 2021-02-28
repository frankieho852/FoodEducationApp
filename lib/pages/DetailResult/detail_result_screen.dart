import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';

class DetailResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FoodProduct tempfood= FoodProduct(name:"Vita Lemon Juice",protein: 1,totalFat: 2,totalCarbonhydrates: 12,energy: 210,image: "assets/images/Vitalemontea.jpg");
    return Scaffold(
      appBar: buildAppBar(tempfood.name),
      body: Body(),

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