import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';

class DetailResult extends StatefulWidget {
  final String searchname;

  DetailResult({Key key, @required this.searchname}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DetailResultState();
}

class _DetailResultState extends State<DetailResult> {

  CollectionReference foodProductCollection =
  FirebaseFirestore.instance.collection('foodProduct');

  String foodProductCategory;
  bool _loading = true;
  FoodProduct tempfood = new FoodProduct();
  List<DailyIntake> tempDaily = [];
  List<AlternativeProduct> alt2product = [];

  void initState() {
    // TODO: implement initState
    super.initState();
   // _setLoading(true);
    //todo:function 1 and store in tempfood
    _getProdcutData();

    //tempfood.calculateTotalNutrient();
    //tempfood.printproduct();

    //todo: function 5 get current user height weight sex->calculate recDaily
    _getUserInfo();

    //todo: function 4 get maxSametype,minSametype by category
    _findMaxMin(foodProductCategory);

    //todo:function 3 and store in alt2product
    _findAlt2product();

  }

  @override
  Widget build(BuildContext context) {

    _setLoading(false);
    print("searchname: " + widget.searchname);
    print("TempObject2: " + tempfood.name);
    print("TempObject2: " + tempfood.category);
    print("alt2: "+ alt2product.last.name);
    //tempfood.calculateTotalNutrient();
    if (tempfood.name == null) {
      log("tempfood is null");
    } else if(tempDaily.isEmpty){
      log("tempDaily is null");
    } else if (alt2product.isEmpty){
      log("alt2product is null");
    } else{
      log("other bug");
    }

    return Scaffold(
      appBar: buildAppBar(tempfood.name),
      body:  Body( //_loading ? Center(child: CircularProgressIndicator()) :
        product: tempfood,
        daily: tempDaily,
        alt2product: alt2product,
      ),
      //bottomNavigationBar: MyBottomNavBar(),
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

  void _setLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  void _getProdcutData() async {
    //_setLoading(true);
    await foodProductCollection.doc("ID1").get().then((snapshot) {

      try {
        foodProductCategory = snapshot.get("category");
        //print("Figo: " + snapshot.get("volumeOrweight").toDouble().toString());
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
            star: snapshot.get("star").toDouble())
        );
        print(snapshot.get("volumeOrweight").toDouble().toString());

        print("bug 4");
      } on StateError catch (e) {
        print("Error: getproduct " + e.message);
      } finally {
        //_setLoading(false);
      }
    });
    print("in abc: " + tempfood.name);
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
    }
  }

  void _findMaxMin(String productCategory) {
    // 3
    var categoryResult =
    foodProductCollection.where('category', isEqualTo: productCategory);

    // method 1
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

    for (String tempLabel in labelTag) {
      Query maxQ = categoryResult
          .orderBy(tempLabel, descending: true)
          .limit(1); //find max
      Query minQ = categoryResult
          .orderBy(tempLabel, descending: false)
          .limit(1); //find min
      double max, min;
      maxQ.get().then((value) => max = value.docs.first.data()[tempLabel]);
      minQ.get().then((value) => min = value.docs.first.data()[tempLabel]);
      tempDaily.add(DailyIntake(
          nutrient: tempLabel,
          maxSametype: max,
          minSametype: min,
          recDaily: 1000));
    }
  }

  void _findAlt2product() {
    // todo: can change to random later
    try {
      var getalt2product = foodProductCollection.where(
          'category', isEqualTo: foodProductCategory).limit(2);

      getalt2product.get().then((value) {
        for (DocumentSnapshot document in value.docs) {
          log("name: " + document.data()["name"]);
          log("image: " + document.data()["image"]);
          alt2product.add(
              AlternativeProduct(name: document.data()["name"],
                  image: document.data()["image"]));
        }
      });
    } on StateError catch (e) {
      print("Error: getalt2product");
    }
  }
}


