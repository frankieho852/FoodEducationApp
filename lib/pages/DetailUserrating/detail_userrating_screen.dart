import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailUserrating/components/body.dart';

class DetailUserrating extends StatelessWidget {
  final FoodProduct product;
  DetailUserrating({Key key,@required this.product}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(product.name),
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