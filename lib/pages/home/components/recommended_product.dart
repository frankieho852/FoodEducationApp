import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';

class RecommendedProduct extends StatelessWidget {
  // const for avoiding rebuilding the widget
  const RecommendedProduct({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          RecommendedProductCard(
            image: "assets/images/product1.jpg",
            title: "Oatly Milk",
            company: "Oatly",
            price: 440,
            press: () {},
          ),
          RecommendedProductCard(
            image: "assets/images/product2.jpg",
            title: "Beyond Meat",
            company: "Impossible Foods",
            price: 440,
            press: () {},
          ),
          RecommendedProductCard(
            image: "assets/images/product3.jpg",
            title: "Whey Protein Powder",
            company: "Purasana",
            price: 440,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class RecommendedProductCard extends StatelessWidget {
  const RecommendedProductCard({
    Key key,
    this.image,
    this.title,
    this.company,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title, company;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.4,
      height: size.height * 0.35,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 2.5,
        ),
        child: InkWell(
          splashColor: kPrimaryColor.withAlpha(30),
          onTap: () {},
          child: Column(
            // todo: resize the image and text correctly
            children: <Widget>[
              Ink.image(
                image: AssetImage(
                  image,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(kDefaultPadding / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title".toUpperCase(),
                      style: Theme.of(context).textTheme.button,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      softWrap: false,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            "$company".toUpperCase(),
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            style: TextStyle(
                              color: kPrimaryColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '\$$price',
                          style: Theme.of(context)
                              .textTheme
                              .button
                              .copyWith(color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
