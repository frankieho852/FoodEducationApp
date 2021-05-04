import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:food_education_app/Userrating.dart';

class DetailUserratingLogic {
  final loadingNotifier = ValueNotifier<bool>(false);

  // ShowLoading _setLoading;
  // ShowDialogCallback _onGetDataError;
  List<Userrating> ratinglist = [];
  CollectionReference foodProductCollection =
      FirebaseFirestore.instance.collection('foodProduct');

  //ShowDialogCallback onGetDataError, ShowLoading loading
  Future<bool> setup(String productName) async {
    loadingNotifier.value = true;
 //   ratinglist.clear();
    bool a = await getUserrating(productName).then((value) => true);

    loadingNotifier.value = false;
    if (a) {
      return true;
    }
    return true;
  }

  Future<void> getUserrating(String productName) async {

    try {
      CollectionReference foodProductCollection =
      FirebaseFirestore.instance.collection('foodProduct');
      //var getComment = foodProductCollection.where('name', isEqualTo: productName);
      var productRef = foodProductCollection.doc(productName);
     // productRef.get().then((value) => value.data()['name']);
      await productRef.collection("commentSet").get().then((snapshot) {
        for (DocumentSnapshot commentData in snapshot.docs) {
          DocumentReference userProfile = FirebaseFirestore.instance
              .collection('userProfile')
              .doc(commentData.id);

          userProfile.get().then((userData) {
            log("Show comment now");
            //log(productRef.data()['name']);
            log("productname: " + productName);
            log("name: " + userData.get("name"));
            log("star: " + commentData.data()['star'].toString());
            log("comment: " + commentData.data()['comment']);

            /*
            productname: productName,
                name: userData.get("name"),
                image: "assets/images/tempUserpicture.jpg", //userData.get("name"),   //todo: iconURL
                star: commentData.data()['star'].toDouble(),
                comment: commentData.data()['comment']));
             */
            log("inlogic  in in ratinglist length: " + ratinglist.length.toString());
            ratinglist.add(Userrating(
                productname: productName,
                name: userData.get("name"),
                image: "assets/images/tempUserpicture.jpg", //userData.get("name"),   //todo: iconURL
                star: commentData.data()['star'].toDouble(),
                comment: commentData.data()['comment']));
          });
        }

      });
    //  return ratinglist;
      // return alt2product;
    } on StateError catch (e) {
      print("Error: getalt2product");
    } finally{
      log("inlogic ratinglist length: " + ratinglist.length.toString());
    }

  }
}
