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
  ShowDialogCallback _onGetDataError;

  FoodProduct product;
  List<DailyIntake> tempDaily = [];
  List<AlternativeProduct> alt2product = [];
  List<double> dailyintake=[];

  String foodProductCategory;


  CollectionReference foodProductCollection =
  FirebaseFirestore.instance.collection('foodProduct');

//ShowDialogCallback onGetDataError, ShowLoading loading
  Future<bool> setup(String searchname) async {

    loadingNotifier.value = true;
    bool a = await getProductData(searchname).then((value) => true);
    bool b = await getUserDailyIntake().then((value) => true);
    bool c = await findMaxMin().then((value) => true);
    bool d = await findAlt2product().then((value) => true);
    print("checkbool");
    print(a); print(b);
    print("checkmaxmin");
    print(dailyintake[0]);
    print(c); print(d);
    loadingNotifier.value = false;

    if(a&&b&&c&&d){
      return true;
    }
    return true;
  }

  Future<void> getProductData(String searchname) async{
    try {                             //searchname
      log("SearchnameinLogic: "+ searchname);
      await foodProductCollection.doc(searchname).get().then((snapshot) {
        foodProductCategory = snapshot.get("category");
        product = new FoodProduct(
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
            star: snapshot.get("star").toDouble()
        );
        product.calculateTotalNutrient();
        product.printproduct();
      });
    } on StateError catch (e) {
      print("Error-getproduct:  " + e.message);
      //   return false;
    } finally {
      //_setLoading(false);

    }
  }

  Future<void> getUserDailyIntake() async {
    // 5
    final User _user = FirebaseAuth.instance.currentUser;
    print("uid: "+_user.uid);
    DocumentReference userInfo =
    FirebaseFirestore.instance.collection('userProfile').doc(_user.uid);
    double height,weight,age;
    String sex;

    try {
      await userInfo.get().then((snapshot) {
        print("Userinfo");

        height = snapshot.get('height').toDouble();
        weight = snapshot.get('weight').toDouble();
        age= snapshot.get('age').toDouble();
        sex = snapshot.get('sex');
      });
      //the following daily recommend calories intake follows Mifflin-St Jeor Equation:
      // BMR = 10Weight + 6.25Height - 5Age + 5(for male)
      // BMR = 10Weight + 6.25Height - 5Age -161(for female)
      double maxCalories = -1;
      if(sex=="Female"){maxCalories=10*weight+6.25*height-5*age+5;}
      if(sex=="Male"){maxCalories=10*weight+6.25*height-5*age-161;}
      double maxProtein =
          maxCalories * 0.15 / 4; //One gram of protein provides 4 kcal.
      double maxCarbohydrate =
          maxCalories * 0.75 / 4; //One gram of carbohydrate provides 4 kcal.
      double maxFat =
          maxCalories * 0.3 / 9; //Fat provides 9 kcal for each gram of fat.
      //these 3 values should added up to be 100% of max calories per day, but the percentage can varies,
      //For example, 100% calories = 15% Proteins+ 55% Carbohydrate +30% Fat
      //or 100% calories = 10% Proteins+ 70% Carbohydrate +20% Fat are also fine
      double maxSugars =
          maxCalories * 0.1 / 4; // One gram of sugar provides 4 kcal.
      double maxSaturatedfat = maxCalories * 0.1 / 9;
      double maxTransfat = maxCalories * 0.01 / 9;
      double maxSodium = 5000;
      dailyintake=[maxCalories,maxProtein,maxFat,maxSaturatedfat,maxTransfat,maxCarbohydrate,maxSugars,maxSodium];
    } on StateError catch (e) {
      print("Error: getUserDailyIntake");
      // return false;
    }
    //  return true;
  }

  Future<void> findMaxMin() async {
    // 3
    int dataSize;

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
      foodProductCollection.where('category', isEqualTo: foodProductCategory);
      await categoryResult.get().then((value) {
        print("size bug");
        print(value.size);
        print(value.size.runtimeType);
        dataSize = value.size;
      });

      if (dataSize == 1 || dataSize == 0) {
        int i=0;
        for (String tempLabel in labelTag) {
          await categoryResult.get().then((value) {



            tempDaily.add(DailyIntake(
                nutrient: tempLabel,
                maxSametype: value.docs.first.data()[tempLabel].toDouble(),
                minSametype: value.docs.first.data()[tempLabel].toDouble(),
                recDaily: dailyintake[i]));
          });
          i++;
        }
      } else {
        int i=0;
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
          print(max);
          print(min);
          log("findmaxmin3 min: " + min.toString());
          tempDaily.add(DailyIntake(
              nutrient: tempLabel,
              maxSametype: max,
              minSametype: min,
              recDaily: dailyintake[i]));
          i++;
        }
      }
      //return tempDaily;
    } on StateError catch (e) {
      print("Error - findmaxmin: " + e.message);

    }
    print(tempDaily.length);
    // return true;
  }

  Future<void> findAlt2product() async {
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
     // return alt2product;
    } on StateError catch (e) {
      print("Error: getalt2product");
    }
  }
}