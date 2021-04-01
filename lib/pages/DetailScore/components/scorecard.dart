import 'package:flutter/material.dart';
class ScoreCard extends StatelessWidget {
  const ScoreCard({
    Key key,
    this.description,
    this.press,
  }) : super(key: key);

  final String description;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      height: size.height * 0.14,
      child: Text("hehe"),
    );
  }
}