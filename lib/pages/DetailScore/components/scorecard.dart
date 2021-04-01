import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
class ScoreCard extends StatelessWidget {
  const ScoreCard({
    Key key,
    this.description,
    this.type,
  }) : super(key: key);

  final String description;
  final String type;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget icon = Icon(
      Icons.dangerous,
      size: size.height * 0.05,
      color: Colors.orange,
    );
    if (type == "check") {
      icon = Icon(
        Icons.check,
        size: size.height * 0.05,
        color: kPrimaryColor,
      );
    }

    return Container(
      height: size.height * 0.08,
      decoration: BoxDecoration(
        border: Border(
          bottom:
              BorderSide(width: 1, color: Colors.grey), // grey as border color
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.07,
            width: size.height * 0.07,
            alignment: Alignment.centerLeft,
            child: icon,
          ),
          Expanded(
            child: Container(
              width: size.width * 0.6,
              color: Colors.white,
              alignment: Alignment.centerLeft,
              child: Text(
                this.description,
                style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
