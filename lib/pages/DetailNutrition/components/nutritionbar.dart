import 'package:flutter/material.dart';
import 'package:food_education_app/dailyintake.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailNutrition/components/minmaxbar.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    // double nutrientper100 = totalnutrient/product.volumeOrweight*100;
    double recommendPercentage =
        totalnutrient*100 / daily.recDaily;
    String unit= getnutrientunit();
    Color percentageColor=getcolor(recommendPercentage);
    String capitalNutrient= getcapitalnutrient(daily.nutrient);

    return Container(
        height: size.height * 0.065,
        color: Colors.transparent,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  //padding: EdgeInsets.all(kDefaultPadding * 0.1),
                  height: size.height * 0.035,
                  width: size.height * 0.035, // ensure sqaure container
                  child: SvgPicture.asset(product.getNutrientImage(daily.nutrient)),
                  // decoration: new BoxDecoration(
                  //     shape: BoxShape.rectangle,
                  //     color: Colors.transparent,
                  //     image: DecorationImage(
                  //         image: AssetImage(
                  //             product.getNutrientImage(daily.nutrient)),
                  //         fit: BoxFit.cover)),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: " " + capitalNutrient + ": "),
                      TextSpan(
                          text: totalnutrient.toString()+" "+unit,
                          style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryColor)),
                    ],
                  ),
                ),
                Flexible(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: size.height * 0.02,
                      width: size.width*0.35,
                      color: Colors.transparent,
                      child: FittedBox(
                        alignment: Alignment.centerRight,
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
                    ),
                  ),
                ),

              ],
            ),
            Row(
              children: [
                // Container(
                //   height:size.height * 0.025 ,
                //   width: size.width * 0.08,
                //   color: Colors.transparent,
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: FittedBox(
                //       child: Column(
                //         children: [
                //           Text("min:"),
                //           Text(daily.minSametype.toInt().toString())
                //         ],
                //       )
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Container(
                    height:size.height * 0.025,
                    width: size.width * 0.8,
                    color: Colors.transparent,
                    child: Minmaxbar(daily: daily,size:size,total:totalnutrient),
                  ),
                ),
                // Container(
                //   height:size.height * 0.025 ,
                //   width: size.width * 0.08,
                //   color: Colors.transparent,
                //   child: Align(
                //     alignment: Alignment.center,
                //     child: FittedBox(
                //         child: Column(
                //           children: [
                //             Text("max:"),
                //             Text(daily.maxSametype.toInt().toString())
                //           ],
                //         )
                //     ),
                //   ),
                // ),
              ],
            ),

          ],
        ));
  }
  String getnutrientunit(){
    String unit="g";
    if (daily.nutrient=="energy"){unit="kcal";}
    if (daily.nutrient=="sodium"){unit="mg";}
    return unit;
  }
  Color getcolor(double temp){
    Color color = Color(0xFF00A299);
    if(temp>10){color= Colors.yellow[600];}
    if(temp>20){color= Colors.orange;}
    if(temp>30){color= Colors.red;}
    return color;
  }
  String getcapitalnutrient(String temp){
    String result = "not found";
    if (temp == "energy") {
      result = "Energy";
    }
    if (temp == "protein") {
      result = "Protein";
    }
    if (temp == "totalFat") {
      result = "Total Fat";
    }
    if (temp == "saturatedFat") {
      result = "Saturated Fat";
    }
    if (temp == "transFat") {
      result = "Trans Fat";
    }
    if (temp == "carbohydrates") {
      result = "Carbohydrates";
    }
    if (temp == "sugars") {
      result = "Sugars";
    }
    if (temp == "sodium") {
      result = "Sodium";
    }
    return result;
  }
}

