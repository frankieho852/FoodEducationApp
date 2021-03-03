import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailAlternative/detail_alternative_screen.dart';
import 'package:food_education_app/pages/DetailUserrating/detail_userrating_screen.dart';

class Triplebox extends StatelessWidget {
  const Triplebox({
    Key key,
    @required this.size,
    @required this.product,
  }) : super(key: key);

  final Size size;
  final FoodProduct product;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/10),
      height: size.height * 0.25, //use dynamic value(change by figo 25/2)
      decoration: BoxDecoration(
        //color: Colors.green,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3.7),
            blurRadius: 14,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailAlternative(
                          product: product,
                        ))),
            child: Container(
              height: size.height * 0.25,
              width: size.width * 0.6 - kDefaultPadding, //ensure enough space
              decoration: BoxDecoration(
                color: Colors.yellow,
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
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text("Alternatives"),
                  ),
                  SizedBox(
                    height: 1,
                    width: size.width * 0.5 - kDefaultPadding,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: size.height * 0.3,
              //color: Colors.red,
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.12,
                    width: size.width * 0.35,
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
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailUserrating(
                                    product: product,
                                  ))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("User Rating"),
                          ),
                          SizedBox(
                            height: 1,
                            width: size.width * 0.30 - kDefaultPadding,
                            child: const DecoratedBox(
                                decoration:
                                    const BoxDecoration(color: Colors.grey)),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            height: size.height * 0.06,
                            width: size.width * 0.2, //ensure enough space
                            decoration: BoxDecoration(
                              color: Color(0xFFF6FAF9), //Color(0xFFF6FAF9)
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset(0, 3.7),
                                  blurRadius: 14,
                                  color: Colors.black.withOpacity(0.08),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  //color: Colors.red,
                                  height: size.height * 0.04,
                                  width: size.width * 0.06,
                                  child: Icon(
                                    Icons.star,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                                Expanded(
                                  child: Container(
                                      //color: Colors.red,
                                      height: size.height * 0.04,
                                      width: size.width * 0.12,
                                      child: FittedBox(
                                          child:
                                              Text(product.star.toString()))),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    height: size.height * 0.12,
                    width: size.width * 0.35,
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
                      // onTap: () =>Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => DetailedScore()
                      //     )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("Score"),
                          ),
                          SizedBox(
                            height: 1,
                            width: size.width * 0.30 - kDefaultPadding,
                            child: const DecoratedBox(
                                decoration:
                                    const BoxDecoration(color: Colors.grey)),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Expanded(
                            child: Container(
                              height: size.height * 0.08,
                              width: size.height * 0.08, // ensure the circle is in a squared box
                              //color: Colors.green,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.green,
                                  image: DecorationImage(
                                      image: AssetImage(product.grade),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
