
import 'package:cloud_firestore/cloud_firestore.dart';
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

    CollectionReference foodProductCollection = FirebaseFirestore.instance.collection('foodProduct');

    return StreamBuilder<QuerySnapshot>(
      stream: foodProductCollection.where('category', isEqualTo: product.category).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );

        }

        List<AlternativeProduct> altproductslist;

        snapshot.data.docs.map((DocumentSnapshot document) {

          int calories = document.data()['energy_100']*document.data()['volumeOrweight'];
          String grade = document.data()['grade'];
          String gradeImagePath = "";
          if(grade == "A+"){
            gradeImagePath = "assets/images/A-minus.jpg";
          } else if (grade == "A"){
            gradeImagePath = "assets/images/A-minus.jpg";

          } else if (grade == "A-"){
            gradeImagePath = "assets/images/A-minus.jpg";

          } else if (grade == "B+"){
            gradeImagePath = "assets/images/A-minus.jpg";

          } else if (grade == "B"){
            gradeImagePath = "assets/images/A-minus.jpg";

          } else if (grade == "B-"){
            gradeImagePath = "assets/images/A-minus.jpg";

          } else if (grade == "C+"){
            gradeImagePath = "assets/images/A-minus.jpg";

          } else if (grade == "C"){
            gradeImagePath = "assets/images/A-minus.jpg";

          } else if (grade == "C-"){
            gradeImagePath = "assets/images/A-minus.jpg";

          } else if (grade == "D"){ // no F grade
            gradeImagePath = "assets/images/A-minus.jpg";

          }

          altproductslist.add(AlternativeProduct(name: document.data()['name'], grade: gradeImagePath, image: document.data()['imageURL'], star: document.data()['star'], calories: calories));
        });

        /*
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
           */
        return Scaffold(
          appBar: buildAppBar(product.name),
          body: Body(altproductslist:altproductslist),
          //bottomNavigationBar: MyBottomNavBar(),
        );
      },
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