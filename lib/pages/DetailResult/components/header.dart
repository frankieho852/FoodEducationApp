//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
//import 'package:food_education_app/size_config.dart';
import 'package:food_education_app/pages/DetailNutrition/detail_nutrition_screen.dart';
import 'package:food_education_app/foodproduct.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
    @required this.product,
  }) : super(key: key);

  final Size size;
  final FoodProduct product;

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);// this is important for using proportionatescreen function
    return Container(
      // explanation: margin between this container and "Recommended section title

      // explanation: height of the wrapping container, including the daily target card
      height: size.height * 0.2,
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
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/10),
              height: size.height*0.18,//use dynamic value(change by figo 25/2)
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
              child: InkWell(
                // onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context)=>
                //     )),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.1,
                      width: size.width * 0.15,// ensure the circle is in a squared box
                      //color: Colors.green,
                      decoration: new BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(
                              image: AssetImage(product.image),
                              fit: BoxFit.cover)),
                    ),
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
            )
          ),
        ],
      ),
    );
  }
}
