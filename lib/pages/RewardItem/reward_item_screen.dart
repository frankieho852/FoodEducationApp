import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/Reward/model/item.dart';

import 'components/body.dart';

class RewardItemScreen extends StatelessWidget {
  final Item item;

  const RewardItemScreen({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: buildAppBar(context),
      body: Body(
        item: item,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: kBackgroundColor,
      elevation: 0,
      leading: IconButton(
        padding: EdgeInsets.only(left: kDefaultPadding),
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      title: Text(
        'Back'.toUpperCase(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
