import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailNutrition/components/nutritionbar.dart';
import 'package:food_education_app/size_config.dart';
import 'package:food_education_app/dailyintake.dart';
class Header extends StatelessWidget {
  Header({
    Key key,
    @required this.size,
    @required this.product,
    @required this.daily,
  }) : super(key: key);

  final Size size;
  FoodProduct product;
  final  List<DailyIntake> daily;
  @override
  Widget build(BuildContext context) {
    return Container(
      // explanation: margin between this container and "Recommended section title
      margin: EdgeInsets.only(bottom: 5),
      // explanation: height of the wrapping container, including the daily target card
      height: size.height * 0.54,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              // Bottom padding not affecting the UI
              bottom: 36 + kDefaultPadding,
            ),
            // explanation: minus 27 to lift this container away up from the wrapping container
            height: size.height * 0.2 -
                67, //here not -27,space is used for "Alternative title"
            decoration: BoxDecoration(
              color: kPrimaryColor,
              // location: the bottom corner of the teal header block
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
          ),
          Positioned(
              top: 10,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3.7),
                      blurRadius: 14,
                      color: Colors.black.withOpacity(0.08),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.only(left:8.0,right:8.0),
                  padding: const EdgeInsets.only(top:1,bottom: 1),
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: daily.length,
                    itemBuilder: (BuildContext context, int index) =>
                        Nutritionbar(daily: daily[index],size: size,product: product),

                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
