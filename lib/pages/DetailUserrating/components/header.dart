//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'userratingCard.dart';
import 'package:food_education_app/Userrating.dart';
import 'commentbox.dart';

class Header extends StatelessWidget {
  Header({
    Key key,
    @required this.size,
    @required this.ratinglist,
    @required this.image,
  }) : super(key: key);

  final Size size;
  List<Userrating> ratinglist;
  String image;

  @override
  Widget build(BuildContext context) {
    //SizeConfig().init(context);// this is important for using proportionatescreen function
    return Container(
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
                  color: Colors.purple,
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
                      margin: const EdgeInsets.fromLTRB(kDefaultPadding / 5,
                          kDefaultPadding / 2, kDefaultPadding / 5, 0),
                      height: size.height * 0.25,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          image: DecorationImage(
                              image: AssetImage(image), fit: BoxFit.cover)),
                    ),
                    Commentbox(size: size),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(kDefaultPadding / 5,
                            kDefaultPadding / 2, kDefaultPadding / 5, 0),
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: ratinglist.length,
                          itemBuilder: (BuildContext context, int index) =>
                              UserratingCard(userrating: ratinglist[index]),
                        ),
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
