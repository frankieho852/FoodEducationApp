import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailAlternative/components/body.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/pages/DetailAlternative/detail_alternative_logic.dart';
import 'package:food_education_app/pages/DetailResult/detailResultScreenLogic.dart';
import 'package:food_education_app/services/service_locator.dart';

class DetailAlternative extends StatefulWidget {
  final FoodProduct product;

  DetailAlternative({Key key, @required this.product}) : super(key: key);

  @override
  _DetailAlternativeState createState() => _DetailAlternativeState();
}

class _DetailAlternativeState extends State<DetailAlternative> {

  /*
  List<AlternativeProduct> altproductslist=[
    AlternativeProduct(name:"Vita Lemon Juice",grade:"assets/images/A-minus.jpg",image:"assets/images/Vitalemontea.jpg",star:4.0,calories:200),
  ];
   */

  CollectionReference foodProductCollection =
      FirebaseFirestore.instance.collection('foodProduct');
  String foodProductCategory;
  List<AlternativeProduct> tempaltproductslist = [];

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // todo: a function to search database by product.catergory -> create a list object with simular products

    CollectionReference foodProductCollection =
        FirebaseFirestore.instance.collection('foodProduct');

    final detailAltLogic = getIt<DetailAlternativeLogic>();

    return FutureBuilder<bool>(
      future: detailAltLogic.setup(widget.product.category), //foodProductCollection.where('category', isEqualTo: foodProductCategory).snapshots(),
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
            child: CircularProgressIndicator(backgroundColor: Colors.white),
          );
        }

        /*
        log("Show alt2 product now");
        log("Cat: " +foodProductCategory);
        var getaltproduct = foodProductCollection.where('category',
            isEqualTo: foodProductCategory);

        getaltproduct.get().then((value) {
          for (DocumentSnapshot document in value.docs) {
            log("Alt2: " + document.data()['name']);
            log("Alt2: " + document.data()["image"]);
            log("Alt2: " + document.data()["energy"].toString());
            log("Alt2: " + document.data()["grade"]);
            log("Alt2: " + document.data()["star"].toString());

            tempaltproductslist.add(AlternativeProduct(
                name: document.data()["name"],
                image: document.data()["image"],
                calories: document.data()["energy"].toDouble(),
                grade: document.data()["grade"],
                star: document.data()["star"].toDouble()
            ));

          }
          log("SIZE: " + tempaltproductslist.length.toString());
        });


////////////////////////////////////////////////////////////////////

        snapshot.data.docs.map((DocumentSnapshot document) {

          log(document.data()['name']);
          log(document.data()["nicknanme"]);
          log(document.data()["photoURL"]);
          tempaltproductslist.add(AlternativeProduct(
              name: document.data()["name"],
              image: document.data()["image"],
              calories: document.data()["energy"],
              grade: document.data()["grade"]));
        });
tempaltproductslist = [
            AlternativeProduct(name:"Vita TM Cold Brew No Sugar Jasmine Tea",grade:"assets/icons/A-1.svg",image:"assets/images/Vita TM Cold Brew No Sugar Jasmine Tea.jpg",star:4.0,calories:0),
            AlternativeProduct(name:"Vita TM Cold Brew No Sugar Dong Ding Oolong Tea",grade:"assets/icons/A-1.svg",image:"assets/images/Vita TM Cold Brew No Sugar Dong Ding Oolong Tea.jpg",star:3,calories:0),
            AlternativeProduct(name:"Vita TM Low Sugar Lemon Tea Drink",grade:"assets/icons/C-3.svg",image:"assets/images/Vitalemontea.jpg",star:3,calories:75),
            AlternativeProduct(name:"Vita TM Lemon Tea Drink",grade:"assets/icons/C-3.svg",image:"assets/images/Vita TM Lemon Tea Drink.jpg",star:4.5,calories:206),
            AlternativeProduct(name:"Vita Chrysanthemum Tea Drink",grade:"assets/icons/C-3.svg",image:"assets/images/Vita Chrysanthemum Tea Drink.jpg",star:3.4,calories:131),
          ];
 */



        return Scaffold(
          appBar: buildAppBar(widget.product.name),
          body: Body(altproductslist: detailAltLogic.tempaltproductslist),
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
