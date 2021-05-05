import 'package:flutter/material.dart';

import '../../../constants.dart';

class Redeem extends StatelessWidget {
  const Redeem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF38134),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(),
              child: Text(
                'Redeem',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
