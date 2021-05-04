
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailUserrating/components/body.dart';
import 'package:food_education_app/Userrating.dart';
import 'package:food_education_app/pages/DetailUserrating/components/detail_userrating_logic.dart';
import 'package:food_education_app/services/service_locator.dart';

class DetailUserrating extends StatefulWidget {

  final FoodProduct product;
  DetailUserrating({Key key,@required this.product}) : super(key:key);

  @override
  _DetailUserratingState createState() => _DetailUserratingState();
}

  class _DetailUserratingState extends State<DetailUserrating> {

    List<Userrating> ratinglist = [];
    final detailUserratingLogic = getIt<DetailUserratingLogic>();
  @override
  Widget build(BuildContext context) {
    // todo: a function to search database by product.name -> create a list object with all comments



    return FutureBuilder<List<Userrating>>(
      future: detailUserratingLogic.getUserrating(widget.product.name), //setup(widget.product.name//foodProductCollection          .where('name', isEqualTo: product.name)        .snapshots()
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error'),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
          //Text("Loading");
        }

        /*
        List<Userrating> ratinglist=[
        //todo: temp value
          Userrating(productname:widget.product.name,name:"Figo",image:"assets/images/tempUserpicture.jpg",star:4,comment:"It taste sweet"),
          Userrating(productname:widget.product.name,name:"Sam",image:"assets/images/tempUserpicture1.jpg",star:2.5,comment:"It taste so bad"),
          Userrating(productname:widget.product.name,name:"Ray",image:"assets/images/tempUserpicture2.jpg",star:3.5,comment:"It taste ok"),
          Userrating(productname:widget.product.name,name:"Frankie",image:"assets/images/tempUserpicture3.jpg",star:1,comment:"I hate lemon tea and this is worst lemon tea ever."),
        ];
         */

        //log("NOWprintuserratin in screen:" + detailUserratingLogic.ratinglist.length.toString());
//snapshot.data
        log("final bug: " + snapshot.data.length.toString());
        return Scaffold(
          appBar: buildAppBar(widget.product.name),
          body:  Body(     //  ratinglist // detailUserratingLogic.ratinglist
              image: widget.product.image, ratinglist: snapshot.data, star: widget.product.star,productname: widget.product.name),
          //bottomNavigationBar: MyBottomNavBar(),
        );
      },
    );
  }


  AppBar buildAppBar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(
        '$title',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}