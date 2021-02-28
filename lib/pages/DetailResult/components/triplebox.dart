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
                          altproduct: product,
                        ))),
            child: Container(
              height: size.height * 0.25,
              width: size.width * 0.6-kDefaultPadding,//ensure enough space
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
                    height: 0.5,
                    width: size.width * 0.5-kDefaultPadding,
                    child: const DecoratedBox(
                      decoration: const BoxDecoration(color: Colors.grey),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: 8,),
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
                      onTap: () =>Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailUserrating(
                                product: product,
                              )
                          )),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Text("User Rating"),
                          ),
                          SizedBox(
                            height: 0.5,
                            width: size.width * 0.30-kDefaultPadding,
                            child: const DecoratedBox(
                                decoration:
                                    const BoxDecoration(color: Colors.grey)),
                          ),
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
                            height: 0.5,
                            width: size.width * 0.30-kDefaultPadding,
                            child: const DecoratedBox(
                                decoration:
                                    const BoxDecoration(color: Colors.grey)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(3.0),
                            // child: Image.asset(
                            //   'assets/image/A-minus.jpg',
                            //   height: size.height * 0.11,
                            //   width: size.width * 0.11,
                            // ),
                          ) //temp use
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
