import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';

class Commentbox extends StatelessWidget {
  Commentbox({
    Key key,
    @required this.size,
  }) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(
            kDefaultPadding / 5, kDefaultPadding / 2, kDefaultPadding / 5, 0),
        height: size.height * 0.06,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(14),
        ));
  }
}
