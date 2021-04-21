import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/size_config.dart';
import 'package:food_education_app/pages/DetailAlternative/components/alternativecard.dart';
import 'package:food_education_app/alternativeproduct.dart';

class Header extends StatelessWidget {
  Header({
    Key key,
    @required this.size,
    @required this.altproductslist,
  }) : super(key: key);

  final Size size;
  List<AlternativeProduct> altproductslist;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);// this is important for using proportionatescreen function
    return Container(
      // explanation: margin between this container and "Recommended section title
      margin: EdgeInsets.only(bottom: getProportionateScreenHeight(5)),
      // explanation: height of the wrapping container, including the daily target card
      height: size.height * 0.75,
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
            height: size.height * 0.2 - 67,//here not -27,space is used for "Alternative title"
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
            top:10,
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/10),
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(4, 4, 4, 4),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: altproductslist.length,
                    itemBuilder: (BuildContext context,int index)=>AlternativeCard(
                        product:altproductslist[index]

                    ),
                  ),
                ),
              ),
            )
          ),
        ],
      ),
    );
  }
}
