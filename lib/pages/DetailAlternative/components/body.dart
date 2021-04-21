import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailAlternative/components/header.dart';
import 'package:food_education_app/alternativeproduct.dart';

class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.altproductslist,
  }) : super(key: key);

  List<AlternativeProduct> altproductslist;

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
                "Alternative",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              )
            ),
          ),
          Header(size: size,altproductslist:altproductslist),
        ],
      ),
    );
  }
}
