import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/size_config.dart';
import 'package:food_education_app/calculategrade.dart';
class Header extends StatelessWidget {
  Header({
    Key key,
    @required this.size,
    @required this.product,
    @required this.scoreArray,
  }) : super(key: key);

  final Size size;
  FoodProduct product;
  ScoreArray scoreArray;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);// this is important for using proportionatescreen function
    return Container(
      // explanation: margin between this container and "Recommended section title
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
      // explanation: height of the wrapping container, including the daily target card
      height: size.height * 0.8,
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
            height: size.height * 0.2 - 67,//here not -27,space is used for "Alternative title"
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
            top:10,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/10),
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
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(kDefaultPadding / 2,
                        kDefaultPadding / 2, kDefaultPadding / 2, kDefaultPadding / 4),
                    height: size.height * 0.25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                            image: AssetImage(product.image), fit: BoxFit.cover)),
                  ),
                  Container(
                    height: size.height * 0.15,
                    color: Colors.red,
                    child: Text("Tempuse:"+scoreArray.grade+scoreArray.cautions.first),
                  ),

                  //gradebox(),
                  //ListView.builder(),



                ],
              ),

            )
          ),
        ],
      ),
    );
  }
}
