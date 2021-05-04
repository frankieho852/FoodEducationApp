import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_education_app/alternativeproduct.dart';

class DetailAlternativeLogic {
  final loadingNotifier = ValueNotifier<bool>(false);
//  ShowLoading _setLoading;
 // ShowDialogCallback _onGetDataError;

  List<AlternativeProduct> tempaltproductslist = [];

  //String foodProductCategory;

  CollectionReference foodProductCollection =
  FirebaseFirestore.instance.collection('foodProduct');

//ShowDialogCallback onGetDataError, ShowLoading loading
  Future<bool> setup(String foodProductCategory) async {
//Vita TM Low Sugar Lemon Tea Drink

    loadingNotifier.value = true;
    bool a = await getAltproduct(foodProductCategory).then((value) => true);

    loadingNotifier.value = false;
    if (a) {
      return true;
    }
    return true;
  }

  Future<void> getAltproduct(String foodProductCategory) async {

    tempaltproductslist.clear();
    try {
      var getalt2product = foodProductCollection
          .where('category', isEqualTo: foodProductCategory);

      await getalt2product.get().then((value) {
        for (DocumentSnapshot document in value.docs) {
          log("name: " + document.data()["name"]);
          log("image: " + document.data()["image"]);
          tempaltproductslist.add(AlternativeProduct(
              name: document.data()["name"],
              image: document.data()["image"],
              calories: document.data()["energy"].toDouble(),
              grade: document.data()["grade"],
              star: document.data()["star"].toDouble()
              ));
        }
      });
      // return alt2product;
    } on StateError catch (e) {
      print("Error: getalt2product");
    }
  }
}