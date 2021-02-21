import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/home/components/daily_target_graph.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // explanation: margin between this container and "Recommended section title
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2),
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
              color: kPrimaryColor,
              // location: the bottom corner of the teal header block
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              // explanation: the height of the daily target card
              height: 150,
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
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        DailyTargetGraph(),
                        SizedBox(
                          width: 15.0,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Target",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(kDefaultPadding / 4),
                                padding: EdgeInsets.all(kDefaultPadding / 4),
                                height: 110,
                                width: 200,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6FAF9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("160g"),
                                          SizedBox(height: 5.0),
                                          Text("Carbs")
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("94g"),
                                          SizedBox(height: 5.0),
                                          Text("Protein")
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text("86g"),
                                          SizedBox(height: 5.0),
                                          Text("Fat")
                                        ]),
                                  ],
                                ),
                              )
                            ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
