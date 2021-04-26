import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/dailyintake.dart';
import 'package:food_education_app/foodproduct.dart';

typedef ShowDialogCallback = void Function(String title, String content);
typedef ShowLoading = void Function(bool loading);

class DetailResultScreenLogic {
  final loadingNotifier = ValueNotifier<bool>(false);
  ShowLoading _setLoading;
  // AuthService _authService;
  ShowDialogCallback _onGetDataError;

  CollectionReference foodProductCollection =
  FirebaseFirestore.instance.collection('foodProduct');


  void setup(ShowDialogCallback onGetDataError, ShowLoading loading) {
   // _authService = authService;
    _onGetDataError = onGetDataError;
    _setLoading = loading;
  }

  Future<void> getProductData(String searchname) async{

    try {                             //searchname
      await foodProductCollection.doc("Temp milk").get().then((snapshot) {
       // foodProductCategory = ;
        return FoodProduct(
            name: snapshot.get("name"),
            category: snapshot.get("category"),
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
            star: snapshot.get("star").toDouble());
      });
    } on StateError catch (e) {
      print("Error-getproduct:  " + e.message);
      //   return false;
    } finally {
      //_setLoading(false);
      print("in abc: ");
    }
  }

  Future<void> getUserInfo() async {
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

  Future<List<DailyIntake>> findMaxMin(String productCategory) async {
    // 3
    int dataSize;
    List<DailyIntake> tempDaily = [];

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
        //dataSize = value.size;
      });

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
      return tempDaily;
    } on StateError catch (e) {
      print("Error - findmaxmin: " + e.message);
      // return false;
    }
    print(tempDaily.length);
    // return true;
  }

  Future<List<AlternativeProduct>> findAlt2product() async {
    // todo: can change to random later
    List<AlternativeProduct> alt2product = [];
    alt2product.clear();
    try {
      var getalt2product = foodProductCollection
          .where('category', isEqualTo: "foodProductCategory")
          .limit(2);

      await getalt2product.get().then((value) {
        for (DocumentSnapshot document in value.docs) {
          log("name: " + document.data()["name"]);
          log("image: " + document.data()["image"]);
          alt2product.add(AlternativeProduct(
              name: document.data()["name"], image: document.data()["image"]));
        }
      });

      return alt2product;
    } on StateError catch (e) {
      print("Error: getalt2product");
      //return false;
    }
    //  return true;
  }
}