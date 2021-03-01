import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';

class DetailResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FoodProduct tempfood = FoodProduct(
        name: "Vita Lemon Tea",
        protein: 0,
        totalFat: 0,
        totalCarbonhydrates: 5,
        energy: 20,
        sodium: 20,
        star: 4.0,
        grade: "assets/images/A-minus.jpg",
        image: "assets/images/Vitalemontea.jpg",
        ingredients: ["bad ingredient", "good ingredient"],);
    // need a List <AlternativeProduct> with 2 element to fill in alternativebox
    List <DailyIntake> tempDaily = [
      DailyIntake(nutrient: "Calories", maxSametype: 40,minSametype: 10,recDaily: 100  ),
      DailyIntake()
    ];
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