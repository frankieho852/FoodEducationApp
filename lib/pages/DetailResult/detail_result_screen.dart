import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';

class DetailResult extends StatelessWidget {
  final String searchname;
  DetailResult({Key key, @required this.searchname}) : super(key: key);

  CollectionReference foodProductCollection = FirebaseFirestore.instance.collection('foodProduct');

  @override
  Widget build(BuildContext context) {
    //todo:function 1 and store in tempfood
    FoodProduct tempfood = FoodProduct(
      name: "Vita Lemon Tea",
      category: "drink",
      volumeOrweight: 250,
      energy: 137.5,
      protein: 10,
      totalFat: 0,
      saturatetedFat: 0,
      transFat: 0,
      totalCarbonhydrates: 10,
      dietarytFibre: 0,
      sugars: 34,
      sodium: 250,
      image: "assets/images/Vitalemontea.jpg",
      grade: "A",
      ingredients: [
        "Water",
        "Sugar",
        "Flavouring",
        "Tea",
        "Lemon juice",
        "Acidity regulator (330 and 332)",
        "Vitamin C",
        "Sweetener (952 and 955)",
        "Antioxidant (304)"
      ],
      star: 3.5,
    );
    tempfood.calculateTotalNutrient();
    tempfood.printproduct();

    //todo: function 5 get current user height weight sex->calculate recDaily
    //todo: function 4 get maxSametype,minSametype by category
    List<DailyIntake> tempDaily = [
      DailyIntake(
          nutrient: "Energy", maxSametype: 600, minSametype: 100, recDaily: 1000),
      DailyIntake(
          nutrient: "Protein", maxSametype: 50, minSametype: 10, recDaily: 100),
      DailyIntake(
          nutrient: "Total fat",
          maxSametype: 40,
          minSametype: 0,
          recDaily: 100),
      DailyIntake(
          nutrient: "Saturated fat", maxSametype: 40, minSametype: 0, recDaily: 100),
      DailyIntake(
          nutrient: "Trans fat", maxSametype: 0, minSametype: 0, recDaily: 100),
      DailyIntake(
          nutrient: "Carbohydrates", maxSametype: 40, minSametype:40, recDaily: 100),
      DailyIntake(
          nutrient: "Sugars", maxSametype: 34, minSametype: 30, recDaily: 100),
      DailyIntake(
          nutrient: "Sodium", maxSametype: 250, minSametype: 150, recDaily: 100),
    ];
    //todo:function 3 and store in alt2product
    List <AlternativeProduct> alt2product=[
      AlternativeProduct(name: "temp1", image:"assets/images/Vitalemontea.jpg"),
      AlternativeProduct(name: "VERY LONG PRODDDDDDDDDDDDDUYCCCCTTT", image:"assets/images/Vitalemontea1.jpg"),
    ];
    return Scaffold(
      appBar: buildAppBar(tempfood.name),
      body: Body(product: tempfood, daily: tempDaily,alt2product: alt2product,),

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
