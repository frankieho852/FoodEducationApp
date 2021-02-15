import 'package:flutter/material.dart';
import 'package:food_education_app/pages/home/components/coupon.dart';
import 'package:food_education_app/pages/home/components/recommended_product.dart';
import 'package:food_education_app/pages/home/components/section_title.dart';
import 'header.dart';
import 'package:food_education_app/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size),
          SectionTitle(title: "Recommended", press: () {}),
          RecommendedProduct(),
          SectionTitle(title: "Coupons", press: () {}),
          Coupon(),
          SizedBox(height: kDefaultPadding),
        ],
      ),
    );
  }
}
