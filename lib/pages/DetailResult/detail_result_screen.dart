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
    // search name => barcode (key)
    foodProductCollection.doc("searchname").get().then((snapshot) {
      try{
        snapshot.get("name");
        snapshot.get("category");
        snapshot.get("volumeOrweight");
        snapshot.get("energy");
        snapshot.get("protein");
        snapshot.get("totalFat");
        snapshot.get("saturatetedFat");
        snapshot.get("transFat");
        snapshot.get("totalCarbonhydrates");
        snapshot.get("dietarytFibre");
        snapshot.get("sugars");

        snapshot.get("sodium");
        snapshot.get("image");
        snapshot.get("grade");
        snapshot.get("ingredients");
        List<dynamic> ingredients = snapshot.data()["ingredients"];
        snapshot.get("star");
      } on StateError catch (e) {
        print("Error: getproduct");
      }
    });


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
    _getUserInfo();

    //todo: function 4 get maxSametype,minSametype by category
    List<DailyIntake> tempbySam = _findMaxMin("productCategory");

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

  void _barcodeSearch(String barcodeID){
    // 2 get foodproduct
    var barcodeSnapshots = foodProductCollection.where("barcode", isEqualTo: barcodeID);
    // barcodeSnapshots.get().docs.map((DocumentSnapshot document) {});
    barcodeSnapshots.get().then((value) {
     value.docs.map((DocumentSnapshot document) {
       document.data()['product.....'];
     // add other ....
      });
    });
  }

  List<DailyIntake> _findMaxMin(String productCategory){
  // 3
    var categoryResult = foodProductCollection.where('category', isEqualTo: productCategory);

  // todo: need to update sorting name maybe
    List<DailyIntake> tempDaily;

    // energy
    Query energyMaxQ = categoryResult.orderBy("energy", descending: true).limit(1); //find max
    Query energyMinQ = categoryResult.orderBy("energy", descending: false).limit(1); //find min
    double energyMax, energyMin;
    energyMaxQ.get().then((value) => energyMax = value.docs.first.data()["energy"]);
    energyMinQ.get().then((value) => energyMin = value.docs.first.data()["energy"]);
    tempDaily.add(DailyIntake(nutrient: "Energy", maxSametype: energyMax, minSametype: energyMin, recDaily: 1000));

  // Protein
    Query proteinMax = categoryResult.orderBy("protein", descending: true).limit(1); //find max
    Query proteinMin = categoryResult.orderBy("protein", descending: false).limit(1); //find min
    proteinMax.get().then((value) => print(value.docs.first.data()["protein"]));
    proteinMin.get().then((value) => print(value.docs.first.data()["protein"]));
  //
    Query totalFatMax = categoryResult.orderBy("totalFat", descending: true).limit(1); //find max
    Query totalFatMin = categoryResult.orderBy("totalFat", descending: false).limit(1); //find min
    totalFatMax.get().then((value) => print(value.docs.first.data()["totalFat"]));
    totalFatMin.get().then((value) => print(value.docs.first.data()["totalFat"]));
  //
    Query saturatedFatMax = categoryResult.orderBy("saturatedFat", descending: true).limit(1); //find max
    Query saturatedFatMin = categoryResult.orderBy("saturatedFat", descending: false).limit(1); //find min
    saturatedFatMax.get().then((value) => print(value.docs.first.data()["saturatedFat"]));
    saturatedFatMin.get().then((value) => print(value.docs.first.data()["saturatedFat"]));

    Query transFatMax = categoryResult.orderBy("transFat", descending: true).limit(1); //find max
    Query transFatMin = categoryResult.orderBy("transFat", descending: false).limit(1); //find min
    transFatMax.get().then((value) => print(value.docs.first.data()["transFat"]));
    transFatMin.get().then((value) => print(value.docs.first.data()["transFat"]));

    Query carbohydratesMax = categoryResult.orderBy("carbohydrates", descending: true).limit(1); //find max
    Query carbohydratesMin = categoryResult.orderBy("carbohydrates", descending: false).limit(1); //find min
    carbohydratesMax.get().then((value) => print(value.docs.first.data()["carbohydrates"]));
    carbohydratesMin.get().then((value) => print(value.docs.first.data()["carbohydrates"]));

    Query sugarsMax = categoryResult.orderBy("sugars", descending: true).limit(1); //find max
    Query sugarsMin = categoryResult.orderBy("sugars", descending: false).limit(1); //find min
    sugarsMax.get().then((value) => print(value.docs.first.data()["sugars"]));
    sugarsMin.get().then((value) => print(value.docs.first.data()["sugars"]));

    Query sodiumMax = categoryResult.orderBy("sodium", descending: true).limit(1); //find max
    Query sodiumMin = categoryResult.orderBy("sodium", descending: false).limit(1); //find min
    sodiumMax.get().then((value) => print(value.docs.first.data()["sodium"]));
    sodiumMin.get().then((value) => print(value.docs.first.data()["sodium"]));
  }

  void _getUserInfo() async {
    // 5
    final User _user = FirebaseAuth.instance.currentUser;
    DocumentReference userInfo = FirebaseFirestore.instance.collection('userprofile').doc(_user.uid);

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
}
