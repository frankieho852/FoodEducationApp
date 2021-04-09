import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';

class DetailResult extends StatelessWidget {
  final String searchname;
  DetailResult({Key key, @required this.searchname}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
    // todo:need a List <AlternativeProduct> with 2 element to fill in alternativebox
    //todo: get current user height weight sex->calculate recDaily
    //todo: get maxSametype,minSametype by category
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
}
