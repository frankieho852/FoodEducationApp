//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/size_config.dart';
import 'package:food_education_app/pages/DetialNutrition/detail_nutrition_screen.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);// this is important for using proportionatescreen function
    return Container(
      // explanation: margin between this container and "Recommended section title
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
      // explanation: height of the wrapping container, including the daily target card
      height: size.height * 0.24,
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
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: Colors.red,
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(14))
                ),
                child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=> DetailedNutrition()
                      )),
                  child: Row(
                    children: [
                      Image.asset('assets/images/bread.jpg',height:getProportionateScreenHeight(150),width: getProportionateScreenWidth(150),),
                      Flexible(
                        child:Card(
                          child: Column(
                            children: [
                              Text("is this product good for you ?"),
                              Row(
                                children: [
                                  Text("3 Checks "),//temp use
                                  Text("2 Cautions"),//temp use
                                ],
                              )
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
