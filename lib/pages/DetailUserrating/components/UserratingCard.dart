import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
//import 'package:flutter/cupertino.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/Userratting.dart';

class UserratingCard extends StatelessWidget {
  const UserratingCard({
    Key key,
    this.rating,
    this.press,
  }) : super(key: key);

  final Userrating rating;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //width: size.width * 0.3,
      height: size.height * 0.10,
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
                    color: Colors.green,
                ),
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
                              "xdxd",
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
                                  "xdxd2",
                                  style: TextStyle(
                                    fontSize: size.width * 0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  width: size.width * 0.01,
                                ),
                              ],
                            )),
                        Container(
                            //color: Colors.lightGreenAccent,
                            height: size.height * 0.04,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "xdxd3" + " Calories",
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
