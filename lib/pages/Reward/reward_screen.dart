import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:food_education_app/constants.dart';

class RewardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final User _user = FirebaseAuth.instance.currentUser;
    var userRef =
        FirebaseFirestore.instance.collection('userProfile').doc(_user.uid);

    return StreamBuilder<DocumentSnapshot>(
        stream: userRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Container(
              alignment: Alignment.center,
              child: Text('Error'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {

          }

          String coupon;
          coupon = snapshot.data.data()['coupon'].toString();

          return Scaffold(
            appBar: AppBar(
              title: Text("Reward"),
            ),
            backgroundColor: kPrimaryColor,
            body: Body(coupon: coupon),
          );
        });
  }
}
