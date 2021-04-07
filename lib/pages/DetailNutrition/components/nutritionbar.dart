import 'package:flutter/material.dart';
import 'package:food_education_app/dailyintake.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailNutrition/components/minmaxbar.dart';
class Nutritionbar extends StatelessWidget {
  const Nutritionbar({
    Key key,
    @required this.daily,
    @required this.size,
    @required this.product,
  }) : super(key: key);

  final DailyIntake daily;
  final Size size;
  final FoodProduct product;
  @override
  Widget build(BuildContext context) {
    double totalnutrient = this.product.getNutrientDouble(daily.nutrient);
    double recommendPercentage =
        (totalnutrient * 100 / this.product.volumeOrweight) * 100 / daily.recDaily;
    String unit= getnutrientunit();
    Color percentageColor=getcolor(recommendPercentage);

    return Container(
        height: size.height * 0.07,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  //padding: EdgeInsets.all(kDefaultPadding * 0.1),
                  height: size.height * 0.035,
                  width: size.height * 0.035, // ensure sqaure container
                  decoration: new BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.transparent,
                      image: DecorationImage(
                          image: AssetImage(
                              product.getNutrientImage(daily.nutrient)),
                          fit: BoxFit.cover)),
                ),
                FittedBox(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: " " + daily.nutrient + ": "),
                        TextSpan(
                            text: totalnutrient.toString()+" "+unit,
                            style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor)),
                      ],
                    ),
                  ),
                ),
                Expanded(child: SizedBox(width: size.width*0.9,)),
                FittedBox(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(text: 'Rec. Daily Intake: '),
                        TextSpan(
                            text: recommendPercentage.toInt().toString() + "%",
                            style: TextStyle(fontWeight: FontWeight.bold,color:percentageColor)),
                      ],
                    ),
                  ),
                ),

              ],
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.yellow,
                child: Minmaxbar(daily: daily,),
              ),
            )
          ],
        ));
  }
  String getnutrientunit(){
    String unit="g";
    if (daily.nutrient=="Energy"){unit="kcal";}
    if (daily.nutrient=="Sodium"){unit="mg";}
    return unit;
  }
  Color getcolor(double temp){
    Color color = Color(0xFF00A299);
    if(temp>10){color= Colors.yellow;}
    if(temp>20){color= Colors.orange;}
    if(temp>30){color= Colors.red;}
    return color;
  }
}
