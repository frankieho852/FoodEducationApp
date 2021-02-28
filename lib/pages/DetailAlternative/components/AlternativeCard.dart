import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
//import 'package:flutter/cupertino.dart';
import 'package:food_education_app/AlternativeProduct.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AlternativeCard extends StatelessWidget {
  const AlternativeCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  final AlternativeProduct product;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //width: size.width * 0.3,
      height: size.height * 0.14,
      //color: Colors.grey,
      child: Card(
        elevation: 0,
        //color: Colors.blue,
        child: InkWell(
            onTap: () {},
            child: Row(
              children: [
                Container(
                    //padding: EdgeInsets.all(kDefaultPadding * 0.1),
                    height: size.height * 0.14,
                    width: size.width * 0.38,
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.13,
                          width: size.width * 0.35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(18.0),
                            child: Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: size.height * 0.05,
                              width: size.height * 0.05,// ensure the circle is in a squared box
                              //color: Colors.green,
                              decoration: new BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: Colors.transparent,
                                 image: DecorationImage(
                                     image: AssetImage(product.grade),
                                     fit: BoxFit.cover)),
                              ),
                            //
                ),

                      ],
                    )),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Expanded(
                  //the width is expanded
                  child: Container(
                    height: size.height * 0.14,
                    //color: Colors.red,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.04,
                          //color: Colors.lightGreenAccent,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              product.name,
                              style: TextStyle(
                                fontSize: size.width * 0.04,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ),
                        Container(
                            height: size.height * 0.04,
                            //color: Colors.yellow,
                            child: Row(
                              children: [
                                Text(
                                  product.star.toString(),
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                RatingBar(
                                  initialRating: product.star,
                                  ratingWidget: RatingWidget(
                                      full: Icon(
                                        Icons.star,
                                        color: kPrimaryColor,
                                      ),
                                      half: Icon(
                                        Icons.star_half,
                                        color: kPrimaryColor,
                                      ),
                                      empty: Icon(
                                        Icons.star_border,
                                        color: kPrimaryColor,
                                      )),
                                  itemPadding:
                                      EdgeInsets.symmetric(horizontal: 1.0),
                                  allowHalfRating: true,
                                  itemSize: size.width * 0.04,
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                )
                              ],
                            )),
                        Container(
                            //color: Colors.lightGreenAccent,
                            height: size.height * 0.04,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.calories.toString() + " Calories",
                                style: TextStyle(
                                  fontSize: size.width *
                                      0.035, //slightly smaller than product name and star
                                  //fontWeight: FontWeight.bold, no bold here
                                ),
                                softWrap: false,
                              ),
                            )),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
