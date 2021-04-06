import 'package:flutter/material.dart';
import 'package:food_education_app/dailyintake.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailNutrition/components/nutritionbar.dart';
import 'package:food_education_app/pages/DetailNutrition/detail_nutrition_screen.dart';
class NutritionBox extends StatelessWidget {
  const NutritionBox({
    Key key,
    @required this.size,
    @required this.product,
    @required this.daily,
  }) : super(key: key);

  final Size size;
  final FoodProduct product;
  final List<DailyIntake> daily;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.35,
      width: size.width,
      child: InkWell(
        onTap: () =>Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailedNutrition(product: product,size: size,daily: daily,)
            )),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3.7),
                blurRadius: 14,
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
               Text("NUTRITIONAL VALUE"),
                SizedBox(
                  height: 1,
                  width: double.infinity,
                  child: const DecoratedBox(
                      decoration:
                      const BoxDecoration(color: Colors.grey)),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) =>
                          Nutritionbar(daily: daily[index],size: size,product: product),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
