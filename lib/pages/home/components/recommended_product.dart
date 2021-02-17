import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';

class RecommendedProduct extends StatelessWidget {
  // todo: is the key parameters necessary?
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
            country: "Oatly",
            price: 440,
            press: () {},
          ),
          RecommendedProductCard(
            image: "assets/images/product2.jpg",
            title: "Beyond Meat",
            country: "Impossible Foods",
            price: 440,
            press: () {},
          ),
          RecommendedProductCard(
            image: "assets/images/product3.jpg",
            title: "Whey Protein Powder",
            country: "Purasana",
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
    this.country,
    this.price,
    this.press,
  }) : super(key: key);

  final String image, title, country;
  final int price;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 2.5,
      ),
      width: size.width * 0.4,
      child: Column(
        // todo: resize the image and text correctly
        children: <Widget>[
          Image.asset(
            image,
            fit: BoxFit.fitHeight,
          ),
          GestureDetector(
            onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 14,
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        TextSpan(
                          text: "$country".toUpperCase(),
                          style: TextStyle(
                            color: kPrimaryColor.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text(
                    '\$$price',
                    style: Theme.of(context)
                        .textTheme
                        .button
                        .copyWith(color: kPrimaryColor),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
