import 'package:flutter/material.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';

class DetailResult extends StatelessWidget {
  final String searchname;
  DetailResult({Key key, @required this.searchname}) : super(key: key);
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
          nutrient: "energy", maxSametype: 600, minSametype: 100, recDaily: 1000),
      DailyIntake(
          nutrient: "protein", maxSametype: 50, minSametype: 10, recDaily: 100),
      DailyIntake(
          nutrient: "total fat",
          maxSametype: 40,
          minSametype: 0,
          recDaily: 100),
      DailyIntake(
          nutrient: "saturated fat", maxSametype: 40, minSametype: 0, recDaily: 100),
      DailyIntake(
          nutrient: "trans fat", maxSametype: 0, minSametype: 0, recDaily: 100),
      DailyIntake(
          nutrient: "carbohydrates", maxSametype: 40, minSametype:40, recDaily: 100),
      DailyIntake(
          nutrient: "sugars", maxSametype: 34, minSametype: 30, recDaily: 100),
      DailyIntake(
          nutrient: "sodium", maxSametype: 250, minSametype: 150, recDaily: 100),
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
}
