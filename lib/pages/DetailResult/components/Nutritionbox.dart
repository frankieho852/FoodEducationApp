import 'package:flutter/material.dart';
import 'package:food_education_app/pages/DetailResult/foodproduct.dart';
import 'package:food_education_app/constants.dart';
class NutritionBox extends StatelessWidget {
  const NutritionBox({
    Key key,
    @required this.size,
    @required this.product,
  }) : super(key: key);

  final Size size;
  final FoodProduct product;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.3,
      width: size.width ,
      child: InkWell(
        // onTap: () =>Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => DetailedNutrition()
        //     )),
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
          padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/10),
          height: size.height*0.18,//use dynamic value(change by figo 25/2)
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 3.7),
                blurRadius: 14,
                color: Colors.black.withOpacity(0.08),
              ),
            ],
          ),
          child: Column(
            children: [
              Text("Nutritional Value"),
              Text("Calories:" + product.energy.toString()),
              Text("A bar is here"),
              Text("Protein:" + product.protein.toString()),
              Text("A bar is here"),
              Text("Fat:" + product.totalFat.toString()),
              Text("A bar is here"),
              Text("Carbs:" + product.totalCarbonhydrates.toString()),
              Text("A bar is here"),
            ],
          ),
        ),
      ),
    );
  }
}
