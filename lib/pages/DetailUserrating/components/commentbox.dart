import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants.dart';

class Commentbox extends StatelessWidget {
  final Size size;
  int commentlength;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double star;

  Commentbox({
    Key key,
    @required this.size,
    @required this.commentlength,
    @required this.star,
  }) : super(key: key);

  Future<String> createTextBox(BuildContext context) {
    TextEditingController _textEditingController = TextEditingController();
    //double newcommentstar; use for star bar
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
                    Text("put a star bar here for choseing star here"),
                    Checkbox(
                        value: isChecked,
                        onChanged: (checked) {
                          setState(() {
                            isChecked = checked;
                          });
                        })
                  ],
                ),
              ),
              actions: [
                MaterialButton(
                  elevation: 5,
                  child: Text('Submit'),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      Navigator.of(context).pop(
                          _textEditingController.text.toString() +
                              " " +
                              isChecked.toString()); //todo:
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
                        direction: Axis.horizontal,),

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
