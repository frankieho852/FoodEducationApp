import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailScore/components/header.dart';
import 'package:food_education_app/foodproduct.dart';


class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.product,
    @required this.scoreArray,
  }) : super(key: key);

  FoodProduct product;
  ScoreArray scoreArray;
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
                "Score",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              )
            ),
          ),
          Header(size: size,product: product,scoreArray:scoreArray),
        ],
      ),
    );
  }
}
