import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'header.dart';
import 'package:food_education_app/Userrating.dart';
class Body extends StatelessWidget {
  Body({
    Key key,
    @required this.ratinglist,
    @required this.image,
    @required this.star,
    @required this.productname,
  }) : super(key: key);

  List<Userrating> ratinglist;
  String productname;
  String image;
  double star;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 30,
            color: kPrimaryColor,
            child: Center(
              child:Text(
                "User Rating",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white),
              )
            ),
          ),
          Header(productname:productname,image:image,size: size,ratinglist:ratinglist,star:star),
        ],
      ),
    );
  }
}
