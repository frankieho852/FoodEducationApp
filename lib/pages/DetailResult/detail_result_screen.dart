import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';
import 'package:food_education_app/pages/DetailResult/detailResultScreenLogic.dart';
import 'package:food_education_app/services/service_locator.dart';

class DetailResult extends StatefulWidget {
  final String searchname;

  const DetailResult({Key key, @required this.searchname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailResultState(); //searchName: this.searchname

}

class _DetailResultState extends State<DetailResult> {
  //String searchName;
 // _DetailResultState({this.searchName});
  //Color passedColor;
  //   String passedColorName;
  //   _PageTwoState({this.passedColor, this.passedColorName});
  CollectionReference foodProductCollection =
      FirebaseFirestore.instance.collection('foodProduct');

  int dataSize;
  String foodProductCategory;
  bool _loading = false;

  void initState() {
    // TODO: implement initState
    super.initState();

    //detailResultLogic.
    //detailResultLogic.setup((title, content) { }, (loading) { })
    /*
    //  _setLoading(true);
    //todo:function 1 and store in tempfood
    //print(foodProductCategory);
    _getProdcutData();
    //tempfood.calculateTotalNutrient();
    //tempfood.printproduct();
    //todo: function 5 get current user height weight sex->calculate recDaily
    _getUserInfo();
    //todo: function 4 get maxSametype,minSametype by category
    _findMaxMin(foodProductCategory);
    //todo:function 3 and store in alt2product
    _findAlt2product();
    // _setLoading(false);
     */
  }

  @override
  Widget build(BuildContext context) {

    final detailResultLogic = getIt<DetailResultScreenLogic>();

    return FutureBuilder<bool>(
        future: detailResultLogic.setup(widget.searchname),
        builder: (BuildContext context, snapshot) {
          //AsyncSnapshot<QuerySnapshot> snapshot
          if (snapshot.hasError) {
            log(snapshot.error.toString());
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

          print("alt2product length:" + detailResultLogic.alt2product.length.toString());
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text(
                widget.searchname, //tempfood.name
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            body: Body(
              // snapshot[0-3]
              product: detailResultLogic.product,  //detailResultLogic
              daily: detailResultLogic.tempDaily,
              alt2product: detailResultLogic.alt2product,
            ), // Center(child: CircularProgressIndicator()):

            //bottomNavigationBar: MyBottomNavBar(),
          );
        });
  }

/*
  // todo: nned to update barcode search function later
  void _barcodeSearch(String barcodeID) {
    // 2 get foodproduct, you must pass barcode(String) to me
    FoodProduct tempfoodByBarcode;
    var barcodeSnapshots =
        foodProductCollection.where("barcode", isEqualTo: barcodeID);
    // barcodeSnapshots.get().docs.map((DocumentSnapshot document) {});
    barcodeSnapshots.get().then((value) {
      value.docs.map((DocumentSnapshot document) {
        try {
          tempfoodByBarcode = FoodProduct(
              name: document.data()["name"],
              category: document.data()["category"],
              volumeOrweight: document.data()["volumeOrweight"],
              energy: document.data()["energy"],
              protein: document.data()["protein"],
              totalFat: document.data()["totalFat"],
              saturatedFat: document.data()["saturatetedFat"],
              transFat: document.data()["transFat"],
              carbohydrates: document.data()["totalCarbonhydrates"],
              dietarytFibre: document.data()["dietarytFibre"],
              sugars: document.data()["sugars"],
              sodium: document.data()["sodium"],
              image: document.data()["image"],
              grade: document.data()["grade"],
              ingredients: document.data()["ingredients"],
              star: document.data()["star"]);
        } on StateError catch (e) {
          print("Error: getproductByBarcode");
        }
      });
    });
  }

  void _getProdcutData() async {
    //_setLoading(true);
    try {
      await foodProductCollection.doc("Temp milk").get().then((snapshot) {
        foodProductCategory = snapshot.get("category");
        tempfood.copy(FoodProduct(
            name: snapshot.get("name"),
            category: foodProductCategory,
            volumeOrweight: snapshot.get("volumeOrweight").toDouble(),
            energy: snapshot.get("energy").toDouble(),
            protein: snapshot.get("protein").toDouble(),
            totalFat: snapshot.get("totalFat").toDouble(),
            saturatedFat: snapshot.get("saturatedFat").toDouble(),
            transFat: snapshot.get("transFat").toDouble(),
            carbohydrates: snapshot.get("carbohydrates").toDouble(),
            dietarytFibre: snapshot.get("dietarytFibre").toDouble(),
            sugars: snapshot.get("sugars").toDouble(),
            sodium: snapshot.get("sodium").toDouble(),
            image: snapshot.get("image"),
            grade: snapshot.get("grade"),
            ingredients: new List<String>.from(snapshot.data()["ingredients"]),
            //snapshot.data()["ingredients"],//List.castFrom(snapshot.data()["ingredients"]), //
            star: snapshot.get("star").toDouble()));
      });
    } on StateError catch (e) {
      print("Error-getproduct:  " + e.message);
      //   return false;
    } finally {
      //_setLoading(false);
      print("in abc: " + tempfood.name);
    }
    //  return true;
  }

  void _getUserInfo() async {
    // 5
    final User _user = FirebaseAuth.instance.currentUser;
    DocumentReference userInfo =
        FirebaseFirestore.instance.collection('userprofile').doc(_user.uid);

    double height, weight;
    String sex;
    try {
      await userInfo.get().then((snapshot) {
        height = snapshot.get('height');
        weight = snapshot.get('weight');
        sex = snapshot.get('sex');
      });
    } on StateError catch (e) {
      print("Error: UserInfo");
      // return false;
    }
    //  return true;
  }

  void _findMaxMin(String productCategory) async {
    // 3
    //int dataSize=0;
    tempDaily.clear();
    List<String> labelTag = [
      "energy",
      "protein",
      "totalFat",
      "saturatedFat",
      "transFat",
      "carbohydrates",
      "sugars",
      "sodium"
    ];
    try {
      var categoryResult =
          foodProductCollection.where('category', isEqualTo: productCategory);
      await categoryResult.get().then((value) {
        print("size bug");
        print(value.size);
        print(value.size.runtimeType);
        dataSize = value.size;
      });
      print("size bug2");
      print(dataSize);
      if (dataSize == 1 || dataSize == 0) {
        for (String tempLabel in labelTag) {
          await categoryResult.get().then((value) => null);
          tempDaily.add(DailyIntake(
              nutrient: tempLabel,
              maxSametype: 5,
              minSametype: 2,
              recDaily: 100));
        }
      } else {
        for (String tempLabel in labelTag) {
          Query maxQ = categoryResult
              .orderBy(tempLabel, descending: true)
              .limit(1); //find max
          Query minQ = categoryResult
              .orderBy(tempLabel, descending: false)
              .limit(1); //find min

          double max, min;

          await maxQ.get().then((value) {
            max = value.docs.first.data()[tempLabel].toDouble();
            print("give me somthing");
            print(value.docs.first.data()[tempLabel].runtimeType);
            print(value.docs.first.data()[tempLabel].toDouble());
            print(max);
          });
          print("out");
          print(max);
          //max = value.docs.first.data()[tempLabel].toDouble()); //double.parse(value.docs.first.data()[tempLabel])

          await minQ.get().then(
              (value) => min = value.docs.first.data()[tempLabel].toDouble());

          log("findmaxmin3 max: " + max.toString());
          print("game");
          print(max);
          print(min);
          log("findmaxmin3 min: " + min.toString());
          tempDaily.add(DailyIntake(
              nutrient: tempLabel,
              maxSametype: max,
              minSametype: min,
              recDaily: 100));
        }
      }
    } on StateError catch (e) {
      print("Error - findmaxmin: " + e.message);
      // return false;
    }
    print(tempDaily.length);
    // return true;
  }

  void _findAlt2product() async {
    // todo: can change to random later
    alt2product.clear();
    try {
      var getalt2product = foodProductCollection
          .where('category', isEqualTo: foodProductCategory)
          .limit(2);

      await getalt2product.get().then((value) {
        for (DocumentSnapshot document in value.docs) {
          log("name: " + document.data()["name"]);
          log("image: " + document.data()["image"]);
          alt2product.add(AlternativeProduct(
              name: document.data()["name"], image: document.data()["image"]));
        }
      });
    } on StateError catch (e) {
      print("Error: getalt2product");
      //return false;
    }
    //  return true;
  }
   */
}
