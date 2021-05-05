import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';
import 'package:food_education_app/pages/DetailResult/detailResultScreenLogic.dart';
import 'package:food_education_app/services/service_locator.dart';

class DetailResult extends StatefulWidget {
  final String searchname;

  const DetailResult({Key key, @required this.searchname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailResultState(); //searchName: this.searchname
}

class _DetailResultState extends State<DetailResult> {
  CollectionReference foodProductCollection =
      FirebaseFirestore.instance.collection('foodProduct');

  int dataSize;
  String foodProductCategory;

  @override
  Widget build(BuildContext context) {

    final detailResultLogic = getIt<DetailResultScreenLogic>();

    return FutureBuilder<bool>(
        future: detailResultLogic.setup(widget.searchname),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            log("Steam error");
            log(snapshot.error.toString());

            return Container(
              alignment: Alignment.center,
              child: Text('Error'),
                color: Colors.white
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

          print("alt2product length:" + detailResultLogic.alt2product.length.toString());
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                widget.searchname,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            body: Body(
              product: detailResultLogic.product,
              daily: detailResultLogic.tempDaily,
              alt2product: detailResultLogic.alt2product,
            ),

            //bottomNavigationBar: MyBottomNavBar(),
          );
        });
  }
}
