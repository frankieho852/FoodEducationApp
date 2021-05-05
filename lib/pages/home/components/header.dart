import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/home/components/daily_target_graph.dart';

class Header extends StatelessWidget {
  const Header({
    Key key,
    @required this.size,
    @required this.dailyintake,
  }) : super(key: key);
  final List<double> dailyintake;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      // explanation: margin between this container and "Recommended section title
      margin: EdgeInsets.only(bottom: kDefaultPadding * 2),
      // explanation: height of the wrapping container, including the daily target card
      height: size.height * 0.2,
      //color: Colors.red,
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
            top: 10,//added by figo(avoid the box show behind the appbar (by figo 27/2/2021)
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/10),
              // explanation: the height of the daily target card
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
              child: Row(
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: size.width*0.05,//this box avoid the graph goees out border(change by figo 25/2)
                      ),
                      DailyTargetGraph(),
                      SizedBox(
                        width: size.width*0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Daily Target",//leave this non dynamic to fit section title size(not change by figo 25/2)
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: size.height*0.01),
                              Container(
                                //margin: EdgeInsets.all(kDefaultPadding / 8),
                                padding: EdgeInsets.symmetric(horizontal:kDefaultPadding /20),
                                height: size.height*0.12,//use dynamic value(change by figo 25/2)
                                width: size.width*0.5,//use dynamic value(change by figo 25/2)
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6FAF9),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(dailyintake[3].toInt().toString()+"g"),
                                          SizedBox(height: size.height*0.01),//use dynamic value(change by figo 25/2)
                                          Text("Carbs")
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(dailyintake[1].toInt().toString()+"g"),
                                          SizedBox(height: size.height*0.01),//use dynamic value(change by figo 25/2)
                                          Text("Protein")
                                        ]),
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(dailyintake[2].toInt().toString()+"g"),
                                          SizedBox(height: size.height*0.01),//use dynamic value(change by figo 25/2)
                                          Text("Fat")
                                        ]),
                                  ],
                                ),
                              )
                            ]),
                      ),
                    ],
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
