import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/Reward/model/item.dart';
import 'package:food_education_app/pages/RewardItem/reward_item_screen.dart';

import 'category_list.dart';
import 'reward_card.dart';
import 'search_box.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
          SearchBox(onChanged: (value) {}),
          CategoryList(),
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                // Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1EFF1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) => RewardCard(
                    itemIndex: index,
                    item: items[index],
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RewardItemScreen(
                            item: items[index],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
