import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/size_config.dart';
import 'package:food_education_app/pages/DetailScore/components/scorecard.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Header extends StatefulWidget {
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
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(
        context); // this is important for using proportionatescreen function
    List<Message> combine=widget.scoreArray.messagearray;
    String selected = "first";
    Color _colorContainer = Color(0xFFF6FAF9);
    return Container(
      // explanation: margin between this container and "Recommended section title
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
      // explanation: height of the wrapping container, including the daily target card
      height: widget.size.height * 0.75,
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
            height: widget.size.height * 0.2 -
                57, //here not -27,space is used for "Alternative title"
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
                      height: widget.size.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          image: DecorationImage(
                              image: AssetImage("assets/images/Vita TM Lemon Tea Drink.jpg"),
                              fit: BoxFit.fitHeight)),
                    ),
                    Container(
                      height: widget.size.height * 0.08,
                      color: Colors.white,
                      margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = 'first';
                                  print("selected = 'first'");
                                  _colorContainer = Colors.orange;
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                color: Colors.transparent,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: GestureDetector(
                                        child: Container(
                                          height: double.infinity,
                                          decoration: new BoxDecoration(
                                            color: _colorContainer,
                                            borderRadius:
                                            BorderRadius.circular(14),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(left: 4,right: 4),
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: widget.size.height * 0.025,
                                                      child: FittedBox(
                                                        fit: BoxFit.fitHeight,
                                                        child: Text(
                                                          widget.scoreArray.checks
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: kPrimaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width:2),
                                                    Icon(
                                                      Icons.check,
                                                      color: kPrimaryColor,
                                                      size: widget.size.height * 0.025,
                                                    ),
                                                  ],
                                                ),
                                                Flexible(child:SizedBox(height:4)),
                                                Container(
                                                  height: widget.size.height*0.025,
                                                  child: FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Text(
                                                      "Checks",
                                                      style: TextStyle(
                                                        color: kPrimaryColor,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: double.infinity,
                                      width: widget.size.width*0.3,
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              height: widget.size.height * 0.08,
                                              width: widget.size.height * 0.08,
                                              child: SvgPicture.asset('assets/icons/C-3.svg'),
                                              // decoration: new BoxDecoration(
                                              //     shape: BoxShape.circle,
                                              //     image: DecorationImage(
                                              //         image:
                                              //         AssetImage(widget.product.getGradeImage()),
                                              //         fit: BoxFit.cover)),
                                            ),


                                          ),
                                          SizedBox(
                                            height: 4,
                                          ),
                                          Container(
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
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            selected = 'second';
                                            print("selected = 'second'");
                                          });
                                        },
                                        child: Container(
                                          height: double.infinity,
                                          decoration: new BoxDecoration(
                                            color: Color(0xFFF6FAF9),
                                            borderRadius:
                                            BorderRadius.circular(14),
                                          ),
                                          child: Container(
                                            margin: EdgeInsets.only(left: 4,right: 4),
                                            color: Colors.transparent,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: widget.size.height * 0.025,
                                                      child: FittedBox(
                                                        fit: BoxFit.fitHeight,
                                                        child: Text(
                                                          widget.scoreArray.cautions
                                                              .toString(),
                                                          style: TextStyle(
                                                            color: Colors.orange,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width:2),
                                                    Icon(
                                                      Icons.dangerous,
                                                      color: Colors.orange,
                                                      size: widget.size.height * 0.025,
                                                    ),
                                                  ],
                                                ),
                                                Flexible(child:SizedBox(height:4)),
                                                Container(
                                                  height: widget.size.height*0.025,
                                                  child: FittedBox(
                                                    fit: BoxFit.fitHeight,
                                                    child: Text(
                                                      "Cautions",
                                                      style: TextStyle(
                                                        color: Colors.orange,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],

                      ),
                    ),

                    //gradebox(),
                    Container(
                      height: widget.size.height*0.35,
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
