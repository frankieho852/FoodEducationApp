import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/Userrating.dart';

class UserratingCard extends StatelessWidget {
  const UserratingCard({
    Key key,
    this.userrating,
    this.press,
  }) : super(key: key);

  final Userrating userrating;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //width: size.width * 0.3,
      //height: size.height * 0.10,
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1,color: Colors.grey), // grey as border color
        ),
      ),

      child: Card(
        elevation: 0,
        //color: Colors.blue,
        child: InkWell(
            onTap: () {},
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment:
                  CrossAxisAlignment.start, // make icon stay top left
              children: [
                Container(
                  //padding: EdgeInsets.all(kDefaultPadding * 0.1),
                  height: size.height * 0.06,
                  width: size.height * 0.06, // ensure sqaure container
                  decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: NetworkImage(userrating.image),
                          fit: BoxFit.cover)),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Expanded(
                  //width expanded
                  child: Container(
                    //height: size.height * 0.12,
                    //width: size.width * 0.6,//width expanded
                   // color: Colors.purple,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //height: size.height * 0.03,//depends by Textsize
                          //width: size.width * 0.4,//width expanded
                          //color: Colors.lightGreenAccent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                //height: size.height * 0.03,
                                width: size.width * 0.4,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    userrating.name,
                                    style: TextStyle(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ),
                              ),
                              Container(
                                //height: size.height * 0.03,
                                width: size.width * 0.12, //ensure enough space
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Container(
                                      //color: Colors.red,
                                      height: size.height * 0.02,
                                      width: size.height * 0.02,
                                      child: Icon(
                                        Icons.star_border,
                                        color: kPrimaryColor,
                                        size: size.height * 0.02,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1,
                                    ),
                                    Expanded(
                                      child: Container(
                                          //color: Colors.red,
                                          height: size.height * 0.02,
                                          //width: size.width * 0.8,
                                          child: FittedBox(
                                              child: Text(
                                            userrating.star.toString(),
                                            style: TextStyle(
                                              fontSize: size.height * 0.02,
                                              //fontWeight: FontWeight.bold,
                                              color: kPrimaryColor,
                                            ),
                                          ))),
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: size.height*0.01,),
                        Container(
                            //height: size.height * 0.05,//height also expanded
                            //width: size.width * 0.4,//width expanded
                            padding: EdgeInsets.only(right: kDefaultPadding),
                           // color: Colors.yellow,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                userrating.comment,
                                style: TextStyle(
                                  fontSize: size.height *
                                      0.02 , //slightly smaller than product name and star
                                  //fontWeight: FontWeight.bold, no bold here
                                ),
                              ),
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
