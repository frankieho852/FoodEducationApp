import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailAlternative/components/body.dart';
import 'package:food_education_app/alternativeproduct.dart';
class DetailAlternative extends StatelessWidget {
  final FoodProduct product;
  DetailAlternative({Key key,@required this.product}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    // todo: a function to search database by product.catergory -> create a list object with simular products
    List<AlternativeProduct> altproductslist = [
      AlternativeProduct(name:"Vita Lemon Juice",grade:"assets/images/A-minus.jpg",image:"assets/images/Vitalemontea.jpg",star:4.0,calories:200),
      AlternativeProduct(name:"A super long nameeeeeeeeeeeeeeeeeee",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.5,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread3",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread4",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:1.4,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:4.1,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
      AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
    ];

    return Scaffold(
      appBar: buildAppBar(product.name),
      body: Body(altproductslist:altproductslist),

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