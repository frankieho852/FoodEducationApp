import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/home/components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  // double height, weight, age = -1;
  // String sex = 'error';
  List<double> dailyintake = [];
  @override
  Widget build(BuildContext context) {
    // double height, weight, age = -1;
    final User _user = FirebaseAuth.instance.currentUser;

    var userRef = FirebaseFirestore.instance.collection('userProfile').doc(_user.uid);

    return FutureBuilder<DocumentSnapshot>(
        future: userRef.get(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {

          }

          double height,weight,age;
          String sex;
          height = snapshot.data.data()['height'].toDouble();
          weight = snapshot.data.data()['weight'].toDouble();
          age = snapshot.data.data()['age'].toDouble();
          sex = snapshot.data.data()['sex'];
          double maxCalories = -1;
          if(sex=="Female"){maxCalories=10*weight+6.25*height-5*age+5;}
          if(sex=="Male"){maxCalories=10*weight+6.25*height-5*age-161;}
          double maxProtein =
              maxCalories * 0.15 / 4; //One gram of protein provides 4 kcal.
          double maxCarbohydrate =
              maxCalories * 0.75 / 4; //One gram of carbohydrate provides 4 kcal.
          double maxFat =
              maxCalories * 0.3 / 9; //Fat provides 9 kcal for each gram of fat.
          //these 3 values should added up to be 100% of max calories per day, but the percentage can varies,
          //For example, 100% calories = 15% Proteins+ 55% Carbohydrate +30% Fat
          //or 100% calories = 10% Proteins+ 70% Carbohydrate +20% Fat are also fine
          dailyintake=[maxCalories,maxProtein,maxFat,maxCarbohydrate];

          return Scaffold(
            appBar: buildAppBar(),
            body: Body(dailyintake:dailyintake),
            //bottomNavigationBar: MyBottomNavBar(),
          );
        }
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      title: Text(
        "Home",
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
