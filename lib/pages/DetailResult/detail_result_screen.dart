import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailResult/components/body.dart';
import 'package:food_education_app/dailyintake.dart';

class DetailResult extends StatelessWidget {
  final String searchname;
  DetailResult({Key key,@required this.searchname}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    FoodProduct tempfood = FoodProduct(
      name: "Vita Lemon Tea",
      volume:400,
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
    // need a List <AlternativeProduct> with 2 element to fill in alternativebox
    List<DailyIntake> tempDaily = [
      DailyIntake(
          nutrient: "Calories",
          maxSametype: 40,
          minSametype: 10,
          recDaily: 100),
      DailyIntake(nutrient: "protein",
      maxSametype: 40,
    minSametype: 0,
    recDaily: 1000),
      DailyIntake(nutrient: "fat",
          maxSametype: 40,
          minSametype: 0,
          recDaily: 1000),
      DailyIntake(nutrient: "sodium",
          maxSametype: 40,
          minSametype: 0,
          recDaily: 1000),
    ];
    return Scaffold(
      appBar: buildAppBar(tempfood.name),
      body: Body(product: tempfood,daily:tempDaily),

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
