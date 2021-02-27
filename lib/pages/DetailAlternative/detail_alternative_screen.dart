import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailAlternative/components/body.dart';

class DetailedAlternative extends StatelessWidget {
  final FoodProduct altproduct;
  DetailedAlternative({Key key,@required this.altproduct}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    FoodProduct tempfood= FoodProduct(name:"Quick Serve Macaroni",protein: 1,totalFat: 2,totalCarbonhydrates: 12,energy: 210);
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