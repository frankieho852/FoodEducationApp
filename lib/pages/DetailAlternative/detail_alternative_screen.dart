import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailAlternative/components/body.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/pages/DetailAlternative/detail_alternative_logic.dart';
import 'package:food_education_app/pages/DetailResult/detailResultScreenLogic.dart';
import 'package:food_education_app/services/service_locator.dart';

class DetailAlternative extends StatefulWidget {
  final FoodProduct product;

  DetailAlternative({Key key, @required this.product}) : super(key: key);

  @override
  _DetailAlternativeState createState() => _DetailAlternativeState();
}

class _DetailAlternativeState extends State<DetailAlternative> {

  /*
  List<AlternativeProduct> altproductslist=[
    AlternativeProduct(name:"Vita Lemon Juice",grade:"assets/images/A-minus.jpg",image:"assets/images/Vitalemontea.jpg",star:4.0,calories:200),
  ];
   */

  CollectionReference foodProductCollection =
      FirebaseFirestore.instance.collection('foodProduct');
  String foodProductCategory;
  List<AlternativeProduct> tempaltproductslist = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final detailAltLogic = getIt<DetailAlternativeLogic>();

    return FutureBuilder<bool>(
      future: detailAltLogic.setup(widget.product.category),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
                child: CircularProgressIndicator(
                    valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor)))
            ,
          );
        }

        return Scaffold(
          appBar: buildAppBar(widget.product.name),
          body: Body(altproductslist: detailAltLogic.tempaltproductslist),
          //bottomNavigationBar: MyBottomNavBar(),
        );
      },
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
