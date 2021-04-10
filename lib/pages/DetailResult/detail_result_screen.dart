import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';

class DetailResult extends StatelessWidget {
  final String searchname;
  DetailResult({Key key, @required this.searchname}) : super(key: key);

  CollectionReference foodProductCollection = FirebaseFirestore.instance.collection('foodProduct');

  @override
  Widget build(BuildContext context) {

    FoodProduct tempfood = FoodProduct(
      name: "Vita Lemon Tea",
      category: "drink",
      volumeOrweight: 400,
      energy_100: 20,
      protein_100: 0,
      totalFat_100: 0,
      saturatetedFat_100: 0,
      transFat_100: 0,
      totalCarbonhydrates_100: 5,
      dietarytFibre_100: 0,
      sugars_100: 5,
      sodium_100: 0,
      image: "assets/images/Vitalemontea.jpg",
      grade: "A",
      ingredients: [
        "water",
        "sugar",
        "flavouring",
        "tea",
        "lemon juice",
        "acidity regulator(330 and 331)",
        "vitamin C",
        "Sweetener(952 and 955)",
        "antioxidant(304)"
      ],
      star: 3.5,
    );
    tempfood.calculateTotalNutrient();
    tempfood.printproduct();
    // todo:need a List <AlternativeProduct> with 2 element to fill in alternativebox
    //todo: get current user height weight sex->calculate recDaily
    //todo: get maxSametype,minSametype by category
    List<DailyIntake> tempDaily = [
      DailyIntake(
          nutrient: "Energy", maxSametype: 40, minSametype: 10, recDaily: 1000),
      DailyIntake(
          nutrient: "Protein", maxSametype: 40, minSametype: 0, recDaily: 10),
      DailyIntake(
          nutrient: "Total fat",
          maxSametype: 40,
          minSametype: 0,
          recDaily: 1000),
      DailyIntake(
          nutrient: "Saturated fat", maxSametype: 40, minSametype: 0, recDaily: 20),
      DailyIntake(
          nutrient: "Trans fat", maxSametype: 40, minSametype: 0, recDaily: 30),
      DailyIntake(
          nutrient: "Carbohydrates", maxSametype: 40, minSametype: 0, recDaily: 40),
      DailyIntake(
          nutrient: "Sugars", maxSametype: 40, minSametype: 0, recDaily: 50),
      DailyIntake(
          nutrient: "Sodium", maxSametype: 40, minSametype: 0, recDaily: 60),
    ];
    return Scaffold(
      appBar: buildAppBar(tempfood.name),
      body: Body(product: tempfood, daily: tempDaily),

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

  void barcodeSearch(String barcodeID){
    // 2
    var x = foodProductCollection.doc(barcodeID);
    x.get().then((value) {
      print(value.data()["category"]);
     // add other ....
    });
  }

  void findMaxMin(String productCategory){
  // 3
    var categoryResult = foodProductCollection.where('category', isEqualTo: productCategory);
    // Calories
    var max = categoryResult.orderBy("energy", descending: true).limit(1); //find max
    categoryResult.orderBy("energy", descending: false).limit(1); //find min
    max.get().then((value) => print(value.docs.first.data()["energy"]));

    // todo: need to update sorting name
  // Protein
    categoryResult.orderBy("protein", descending: true).limit(1); //find max
    categoryResult.orderBy("protein", descending: false).limit(1); //find min
  //
    categoryResult.orderBy("totalFat", descending: true).limit(1); //find max
    categoryResult.orderBy("totalFat", descending: false).limit(1); //find min
  //
    categoryResult.orderBy("saturatedFat", descending: true).limit(1); //find max
    categoryResult.orderBy("saturatedFat", descending: false).limit(1); //find min

    categoryResult.orderBy("transFat", descending: true).limit(1); //find max
    categoryResult.orderBy("transFat", descending: false).limit(1); //find min

    categoryResult.orderBy("carbohydrates", descending: true).limit(1); //find max
    categoryResult.orderBy("carbohydrates", descending: false).limit(1); //find min

    categoryResult.orderBy("sugars", descending: true).limit(1); //find max
    categoryResult.orderBy("sugars", descending: false).limit(1); //find min

    categoryResult.orderBy("sodium", descending: true).limit(1); //find max
    categoryResult.orderBy("sodium", descending: false).limit(1); //find min
  }

  Future<void> getUserInfo() async {

    CollectionReference userCollection = FirebaseFirestore.instance.collection('userProfile');

    final User _user = FirebaseAuth.instance.currentUser;

    DocumentReference userInfo = FirebaseFirestore.instance.collection('userprofile').doc(_user.uid);

    try {
      await userInfo.get().then((snapshot) {
        double height = snapshot.get('height');
        double weight = snapshot.get('weight');
        String sex = snapshot.get('sex');
      });
    } on StateError catch (e) {
      print("Error: UserInfo");
    }
  }
}
