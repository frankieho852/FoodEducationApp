import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailResult/components/triplebox.dart';
import 'header.dart';
import 'Nutritionbox.dart';
import 'package:food_education_app/foodproduct.dart';

class Body extends StatelessWidget {
  const Body({
    Key key,
    @required this.product,
  }) : super(key: key);
  final FoodProduct product;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size),
          SizedBox(height: size.height * 0.02),
          NutritionBox(
            size: size,
            product: product,
          ),
          SizedBox(height: size.height * 0.02),
          Triplebox(
            size: size,
            product: product,
          ),
        ],
      ),
    );
  }
}
