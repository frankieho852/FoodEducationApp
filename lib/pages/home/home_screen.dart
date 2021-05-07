import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/home/components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  // double height, weight, age = -1;
  // String sex = 'error';
  List<double> dailyintake = [100,100,100];
  @override
  Widget build(BuildContext context) {
    // double height, weight, age = -1;
    final User _user = FirebaseAuth.instance.currentUser;

    var userRef = FirebaseFirestore.instance.collection('userProfile').doc(_user.uid);

    return StreamBuilder<DocumentSnapshot>(
        stream: userRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: Text('Error'),
            );
          }

          if(!snapshot.hasData){

            return Scaffold(
                body: Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor)))

          );

          }

          if (snapshot.connectionState == ConnectionState.waiting) {

            /*
            return Scaffold(
                body: Center(
                child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor)))

          );

             */
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
  /*
  Future<void> _getUserDailyIntake() async {
    // 5
    final User _user = FirebaseAuth.instance.currentUser;
    print("uid: "+_user.uid);
    DocumentReference userInfo =
    FirebaseFirestore.instance.collection('userProfile').doc(_user.uid);
    double height,weight,age;
    String sex;

    try {
      await userInfo.get().then((snapshot) {
        height = snapshot.get('height').toDouble();
        weight = snapshot.get('weight').toDouble();
        age= snapshot.get('age').toDouble();
        sex = snapshot.get('sex');
      });
      //the following daily recommend calories intake follows Mifflin-St Jeor Equation:
      // BMR = 10Weight + 6.25Height - 5Age + 5(for male)
      // BMR = 10Weight + 6.25Height - 5Age -161(for female)
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
      dailyintake=[maxCalories,maxProtein,maxFat,maxCarbohydrate,];
    } on StateError catch (e) {
      print("Error: getUserDailyIntake");
      // return false;
    }
    //  return true;
  }

   */
}
