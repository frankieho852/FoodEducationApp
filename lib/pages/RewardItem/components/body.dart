import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/Reward/model/item.dart';

import 'redeem.dart';
import 'item_image.dart';

class Body extends StatelessWidget {
  final Item item;

  const Body({Key key, this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
              decoration: BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Hero(
                      tag: '${item.id}',
                      child: ItemPoster(
                        size: size,
                        image: item.image,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: kDefaultPadding / 2),
                    child: Text(
                      item.title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  Text(
                    '\$${item.price}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFF38134),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
                    child: Text(
                      item.description,
                      style: TextStyle(color: Color(0xFF747474)),
                    ),
                  ),
                  SizedBox(height: kDefaultPadding),
                ],
              ),
            ),
            Redeem(),
          ],
        ),
      ),
    );
  }
}
