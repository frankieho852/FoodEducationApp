import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants.dart';

class Commentbox extends StatelessWidget {
  final Size size;
  int commentlength;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double star;
  String productname;
  final TextEditingController _textEditingController = TextEditingController();

  Commentbox({
    Key key,
    @required this.size,
    @required this.productname,
    @required this.commentlength,
    @required this.star, //this star is overall star in firebase
  }) : super(key: key);

  Future<String> createTextBox(BuildContext context) {
    //double newcommentstar; use for star bar
    double uploadstar2 = 3;
    bool isChecked = false;
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Add Your Comment"),
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize
                      .min, // make whole form use least vertical space
                  children: [
                    TextFormField(
                      controller: _textEditingController,
                      validator: (value) {
                        return value.isNotEmpty
                            ? null
                            : "Invalid Empty Comment";
                      },
                      decoration:
                          InputDecoration(hintText: "Enter Your Comment"),
                    ),
                    RatingBar(
                      initialRating: 3,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      ratingWidget: RatingWidget(
                        full: Icon(
                          Icons.star,
                          color: kPrimaryColor,
                          size: 2,
                        ),
                        half: Icon(
                          Icons.star_half,
                          color: kPrimaryColor,
                          size: 2,
                        ),
                        empty: Icon(
                          Icons.star_border,
                          color: kPrimaryColor,
                          size: 2,
                        ),
                      ),
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      onRatingUpdate: (rating) {
                        setState(() {
                          uploadstar2 = rating;
                        });
                        //print(rating);
                      },
                    ),
                    // Checkbox(
                    //     value: isChecked,
                    //     onChanged: (checked) {
                    //       setState(() {
                    //         isChecked = checked;
                    //       });
                    //     })
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  elevation: 5,
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      final User _user = FirebaseAuth.instance.currentUser;
                      try {
                        CollectionReference productComment = FirebaseFirestore
                            .instance
                            .collection('foodProduct')
                            .doc(productname)
                            .collection("commentSet");
                        DocumentReference productCommentByUser =
                            productComment.doc(_user.uid);
                        productCommentByUser.get().then((doc) {
                          if (doc.exists) {
                            // if the user already has a comment in firebase -> update
                            productCommentByUser
                                .update({
                                  'comment': _textEditingController.text.trim(),
                                  "star": uploadstar2
                                })
                                .then((value) => print(
                                    "Comment Updated" + uploadstar2.toString()))
                                .catchError((error) => print(
                                    "Failed to update your comment: $error"));
                            //todo: calulate the current star by user(eg. user A 5 star, user B, 4 star, overall star=4.5), and update to firestore
                            double updatestar = 0;
                            FirebaseFirestore.instance
                                .collection('foodProduct')
                                .doc(productname)
                                .update({
                              'star': updatestar,
                            });
                          } else {
                            // if not, create one
                            DocumentReference user = FirebaseFirestore.instance.collection("userProfile").doc(_user.uid);
                            user.get().then((value) {
                              //var a = value.data()['name'];
                              //var b = value.data()['userIcon'];

                            productComment
                                .doc(_user.uid)
                                .set({
                                  'commenter': value.data()['name'],
                                  'commenterIcon': value.data()['iconURL'],  // todo: value.data()['userIcon']
                                  'comment': _textEditingController.text.trim(),
                                  'star': uploadstar2
                                })
                                .then((value) => print("New comment"))
                                .catchError((error) => print(
                                    "Failed to create your comment: $error"));
                            });
                            double updatestar = 0;
                            //todo: calulate the current star by user(eg. user A 5 star, user B, 4 star, overall star=4.5), and update to firestore
                            FirebaseFirestore.instance
                                .collection('foodProduct')
                                .doc(productname)
                                .update({
                              'star': updatestar,
                            });
                          }
                        });
                      } catch (error) {
                        print("Error getting document:" + error);
                      }
                      Navigator.of(context).pop(
                          _textEditingController.text.toString() +
                              " " +
                              uploadstar2.toString() +
                              isChecked.toString());
                    }
                    ;
                  },
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(kDefaultPadding / 2,
          kDefaultPadding / 4, kDefaultPadding / 2, kDefaultPadding / 4),
      height: size.height * 0.06,
      decoration: BoxDecoration(
        color: Color(0xFFF6FAF9),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          SizedBox(width: kDefaultPadding / 2),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(1),
              height: size.height * 0.04,
              color: Color(0xFFF6FAF9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        star.toString(),
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: kDefaultPadding / 10,
                      ),
                      RatingBarIndicator(
                        rating: star,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: kPrimaryColor,
                        ),
                        itemCount: 5,
                        itemSize: size.height * 0.025,
                        direction: Axis.horizontal,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        commentlength.toString() + " comments ",
                        style: TextStyle(
                          fontSize: size.height * 0.02,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          createTextBox(context).then((value) => print(
                              value)); //todo: this function currently catch the textfield string and checkbox boolean and then print the string in console
                          //todo: make these value pass to firestore and also each user can only pass once
                          //todo: if user already passed before, the button change to another function to edit the comment in firestore

                          // todo: I need product name
                          //String temp= createTextBox(context);
                          print("done upload function");
                          // final User _user = FirebaseAuth.instance.currentUser;
                          //
                          // try{
                          //   CollectionReference productComment = FirebaseFirestore.instance.collection('foodProduct').doc("product name").collection("commentSet");
                          //   DocumentReference productCommentByUser = productComment.doc(_user.uid);
                          //   productCommentByUser.get().then((doc) {
                          //     if (doc.exists) { // if the user already has a comment in firebase -> update
                          //       productCommentByUser.update({'comment': _textEditingController.text.trim(), "star": 0})
                          //           .then((value) => print("Comment Updated"))
                          //           .catchError((error) => print("Failed to update your comment: $error"));
                          //
                          //     } else {  // if not, create one
                          //       productComment.doc(_user.uid).set({
                          //         'comment': _textEditingController.text.trim(), 'star': star})
                          //           .then((value) => print("New comment"))
                          //           .catchError((error) => print("Failed to post your comment: $error"));
                          //     }
                          //   });
                          // } catch(error){
                          //   print("Error getting document:" + error);
                          // }
                        },
                        child: FittedBox(child: Icon(Icons.add)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(width: kDefaultPadding / 2),
        ],
      ),
    );
  }
}
