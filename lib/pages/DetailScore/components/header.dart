import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/size_config.dart';
import 'package:food_education_app/pages/DetailScore/components/scorecard.dart';
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
    SizeConfig().init(
        context); // this is important for using proportionatescreen function
    List<String> caution = scoreArray.cautions;
    List<String> checks = scoreArray.checks;
    List<String> combine=scoreArray.checks+scoreArray.cautions;
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
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(
                          kDefaultPadding / 2,
                          kDefaultPadding / 2,
                          kDefaultPadding / 2,
                          kDefaultPadding / 4),
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          image: DecorationImage(
                              image: AssetImage(product.image),
                              fit: BoxFit.cover)),
                    ),
                    Container(
                      height: size.height * 0.12,
                      color: Colors.white,
                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: double.infinity,
                                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      decoration: new BoxDecoration(
                                        color: Color(0xFFF6FAF9),
                                        borderRadius:
                                        BorderRadius.circular(14),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.check,
                                                color: kPrimaryColor,
                                                size: size.height * 0.03,
                                              ),
                                              SizedBox(width:2),
                                              Container(
                                                height: size.height * 0.03,
                                                child: FittedBox(
                                                  child: Text(
                                                    scoreArray.checks.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: kPrimaryColor,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                          SizedBox(height:4),
                                          FittedBox(
                                              child: Text(
                                                "Checks",
                                                style: TextStyle(
                                                  color: kPrimaryColor,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: double.infinity,
                                    width: size.width*0.2,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            height: size.height * 0.08,
                                            width: size.height * 0.08,
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                    image:
                                                    AssetImage(product.getGradeImage()),
                                                    fit: BoxFit.cover)),
                                          ),

                                        ),
                                        SizedBox(
                                          height: size.height * 0.01,
                                        ),
                                        Container(
                                          height: size.height * 0.03,
                                          child: FittedBox(
                                            child: Text(
                                              "Score",
                                              style: TextStyle(
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      height: double.infinity,
                                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                                      decoration: new BoxDecoration(
                                        color: Color(0xFFF6FAF9),
                                        borderRadius:
                                        BorderRadius.circular(14),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.dangerous,
                                                color: Colors.orange,
                                                size: size.height * 0.03,
                                              ),
                                              SizedBox(width:2),
                                              Container(
                                                height: size.height * 0.03,
                                                child: FittedBox(
                                                  child: Text(
                                                    scoreArray.cautions.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                ),
                                              ),


                                            ],
                                          ),
                                          SizedBox(height:4),
                                          FittedBox(
                                              child: Text(
                                                "Cautions",
                                                style: TextStyle(
                                                  color: Colors.orange,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),

                    //gradebox(),
                    Container(
                      height: size.height*0.35,
                      padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                      child: ListView.builder(
                        physics: ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: combine.length,
                        itemBuilder: (BuildContext context, int index) =>
                            ScoreCard(description: combine[index],type:"check"),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
