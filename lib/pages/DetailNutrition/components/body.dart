import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailNutrition/components/header.dart';
import 'package:food_education_app/foodproduct.dart';


class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.product,
  }) : super(key: key);
  FoodProduct product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 40,
            color: kPrimaryColor,
            child: Center(
              child:Text(
                "NUTRITIONAL VALUE",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )
            ),
          ),
          Header(size: size,product: product),
        ],
      ),
    );
  }
}
