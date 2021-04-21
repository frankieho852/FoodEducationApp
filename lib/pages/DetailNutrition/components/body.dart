import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailNutrition/components/header.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/dailyintake.dart';
import 'package:food_education_app/pages/DetailNutrition/components/ingredientbox.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.product,
    @required this.daily,
  }) : super(key: key);
  FoodProduct product;
  final  List<DailyIntake> daily;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30,
            color: kPrimaryColor,
            child: Center(
              child:Text(
                "NUTRITIONAL VALUE",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              )
            ),
          ),
          Header(size: size,product: product,daily:daily),
          SizedBox(height: size.height * 0.02),
          IngredientBox(ingredient:product.ingredients,size: size),
        ],
      ),
    );
  }
}
