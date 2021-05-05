
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/Userrating.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailUserrating/components/body.dart';

class DetailUserrating extends StatelessWidget {

  FoodProduct product;
  DetailUserrating({Key key,@required this.product}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    // todo: a function to search database by product.name -> create a list object with all comments

    var ref =
    FirebaseFirestore.instance.collection('foodProduct').doc(product.name).collection("commentSet");
    return StreamBuilder<QuerySnapshot>(
      stream: ref.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
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

        List<Userrating> ratinglist = [];
        log("NEW TEST userrating1");
        snapshot.data.docs.forEach((element) {
          log("NEW TEST userrating2");
          log(element.data()['star'].toString());
          log(element.data()['comment']);
          ratinglist.add(Userrating(productname:product.name,name:element.data()['commenter'], image:element.data()['commenterIcon'],star:element.data()['star'].toDouble(),comment:element.data()['comment']));
        });

        /*
        List<Userrating> ratinglist=[
        //todo: temp value
          Userrating(productname:widget.product.name,name:"Figo",image:"assets/images/tempUserpicture.jpg",star:4,comment:"It taste sweet"),
          Userrating(productname:widget.product.name,name:"Sam",image:"assets/images/tempUserpicture1.jpg",star:2.5,comment:"It taste so bad"),
          Userrating(productname:widget.product.name,name:"Ray",image:"assets/images/tempUserpicture2.jpg",star:3.5,comment:"It taste ok"),
          Userrating(productname:widget.product.name,name:"Frankie",image:"assets/images/tempUserpicture3.jpg",star:1,comment:"I hate lemon tea and this is worst lemon tea ever."),
        ];
         */

        if (snapshot.connectionState == ConnectionState.done) {
         //log("final bug: " + snapshot.data.length.toString());
          log(snapshot.data.runtimeType.toString());
        }

        return Scaffold(
          appBar: buildAppBar(product.name),
          body:  Body(
              image: product.image, ratinglist: ratinglist, star: product.star,productname: product.name),
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