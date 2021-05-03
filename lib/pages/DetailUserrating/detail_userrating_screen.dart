
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailUserrating/components/body.dart';
import 'package:food_education_app/Userrating.dart';
class DetailUserrating extends StatelessWidget {
  final FoodProduct product;
  DetailUserrating({Key key,@required this.product}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    // todo: a function to search database by product.name -> create a list object with all comments

    CollectionReference foodProductCollection =
    FirebaseFirestore.instance.collection('foodProduct');

    return StreamBuilder<QuerySnapshot>(
      stream: foodProductCollection
          .where('name', isEqualTo: product.name)
          .snapshots(),
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
          //Text("Loading");
        }


        List<Userrating> ratinglist=[];
        //todo: temp value
        /*
          Userrating(productname:product.name,name:"Figo",image:"assets/images/tempUserpicture.jpg",star:4,comment:"It taste sweet"),
          Userrating(productname:product.name,name:"Sam",image:"assets/images/tempUserpicture1.jpg",star:2.5,comment:"It taste so bad"),
          Userrating(productname:product.name,name:"Ray",image:"assets/images/tempUserpicture2.jpg",star:3.5,comment:"It taste ok"),
          Userrating(productname:product.name,name:"Frankie",image:"assets/images/tempUserpicture3.jpg",star:1,comment:"I hate lemon tea and this is worst lemon tea ever."),

           */
        snapshot.data.docs.map((DocumentSnapshot productDoc) {

          productDoc.reference.collection('commentSet').get().then((snapshot) {
            for (DocumentSnapshot commentData in snapshot.docs) {
              DocumentReference userProfile = FirebaseFirestore.instance
                  .collection('userProfile')
                  .doc(commentData.id);

              userProfile.get().then((userData) {

                ratinglist.add(Userrating(
                    productname: productDoc.data()['name'],
                    name: userData.get("nicknanme"),
                    image: userData.get("photoURL"),
                    star: commentData.data()['star'],
                    comment: commentData.data()['comment']));
              });
            }
          });
        });

        return new Scaffold(
          appBar: buildAppBar(product.name),
          body: Body(
              image: product.image, ratinglist: ratinglist, star: product.star,productname: product.name,),
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