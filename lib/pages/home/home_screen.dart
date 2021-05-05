import 'package:flutter/material.dart';
import 'package:food_education_app/pages/home/components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  double height, weight, age = -1;
  String sex = 'error';
  @override
  Widget build(BuildContext context) {
    double height, weight, age = -1;
    final User _user = FirebaseAuth.instance.currentUser;
    print("uid: " + _user.uid);
    var ref = FirebaseFirestore.instance.collection('userProfile');
    return StreamBuilder<QuerySnapshot>(
      stream: ref.snapshots(),
      builder: (context, snapshot) {
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
          //Text("Loading");
        }
        //todo:get height, weight, age
        return Scaffold(
          appBar: buildAppBar(),
          body: Body(test:10),
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
