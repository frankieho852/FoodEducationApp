import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/alternativeproduct.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/pages/DetailAlternative/detail_alternative_screen.dart';
import 'package:food_education_app/pages/DetailUserrating/detail_userrating_screen.dart';
import 'package:food_education_app/pages/DetailScore/detail_score_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Triplebox extends StatelessWidget {
  const Triplebox({
    Key key,
    @required this.size,
    @required this.product,
    @required this.scoreArray,
    @required this.alt2product,
  }) : super(key: key);
  final Size size;
  final FoodProduct product;
  final ScoreArray scoreArray;
  final List<AlternativeProduct> alt2product;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      //padding: EdgeInsets.symmetric(horizontal: kDefaultPadding/10),
      height: size.height * 0.25,
      //use dynamic value(change by figo 25/2)
      decoration: BoxDecoration(
        //color: Colors.green,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 3.7),
            blurRadius: 14,
            color: Colors.black.withOpacity(0.08),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (alt2product.length > 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailAlternative(
                              product: product,
                            )));
              }
            },
            child: Container(
              height: size.height * 0.25,
              width: size.width * 0.6 - kDefaultPadding, //ensure enough space

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 3.7),
                    blurRadius: 14,
                    color: Colors.black.withOpacity(0.08),
                  ),
                ],
              ),
              child: Container(
                margin:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text("Alternatives"),
                    ),
                    SizedBox(
                      height: 1,
                      width: double.infinity,
                      child: const DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.grey),
                      ),
                    ),
                    SizedBox(
                      height: 1,
                    ),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: alt2product.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Container(
                            height: size.height * 0.104,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: CachedNetworkImage(
                                          imageUrl: alt2product[index].image,
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            height: size.height * 0.104,
                                            width: size.width * 0.25,
                                            decoration: new BoxDecoration(
                                              // color: Colors.transparent,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    alt2product[index].image),
                                                //imageProvider
                                                fit: BoxFit.fitHeight,
                                              ),
                                            ),
                                          ),
                                          placeholder: (context, url) => Container(
                                              alignment: Alignment.center,
                                              height: size.height * 0.104,
                                              width: size.width * 0.25,
                                              child: CircularProgressIndicator(
                                                  valueColor:
                                                      new AlwaysStoppedAnimation<
                                                              Color>(
                                                          kPrimaryColor))),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),

                                        /*
                                        Container(
                                          height: size.height * 0.104,
                                          width: size.width * 0.25,
                                          decoration: new BoxDecoration(
                                              //color: Colors.transparent,
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      alt2product[index].image),
                                                  fit: BoxFit.fitHeight)),
                                        ),

                                             */
                                      ),

                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Container(
                                          margin:
                                              EdgeInsets.only(top: 2, left: 8),
                                          padding: EdgeInsets.all(3),
                                          height: size.height * 0.03,
                                          width: size.height * 0.03,
                                          // ensure the circle is in a squared box
                                          decoration: new BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            shape: BoxShape.rectangle,
                                            color:
                                                Colors.black.withOpacity(0.3),
                                          ),
                                          child: FittedBox(
                                            child: Text(
                                                (index + 1).toString() + "."),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8),
                                    color: Colors.white,
                                    child: Text(
                                      alt2product[index].name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                  width: double.infinity,
                                  child: const DecoratedBox(
                                    decoration:
                                        const BoxDecoration(color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              height: size.height * 0.3,
              //color: Colors.red,
              child: Column(
                children: [
                  Container(
                    height: size.height * 0.12,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3.7),
                          blurRadius: 14,
                          color: Colors.black.withOpacity(0.08),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailUserrating(
                                    product: product,
                                  ))),
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "User Rating",
                              ),
                            ),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: const DecoratedBox(
                                  decoration:
                                      const BoxDecoration(color: Colors.grey)),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            Flexible(
                              child: Container(
                                height: size.height * 0.06,
                                width: size.width * 0.2, //ensure enough space
                                decoration: BoxDecoration(
                                  color: Color(0xFFF6FAF9), //Color(0xFFF6FAF9)
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 3.7),
                                      blurRadius: 14,
                                      color: Colors.black.withOpacity(0.08),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Container(
                                      //color: Colors.red,
                                      height: size.height * 0.04,
                                      width: size.width * 0.06,
                                      child: Icon(
                                        Icons.star,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Expanded(
                                      child: Container(
                                          //color: Colors.red,
                                          height: size.height * 0.04,
                                          width: size.width * 0.12,
                                          child: FittedBox(
                                              child: Text(
                                                  product.star.toString()))),
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Container(
                    height: size.height * 0.12,
                    width: size.width * 0.35,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3.7),
                          blurRadius: 14,
                          color: Colors.black.withOpacity(0.08),
                        ),
                      ],
                    ),
                    child: InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailedScore(
                                    product: product,
                                    scoreArray: scoreArray,
                                  ))),
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text("Score"),
                            ),
                            SizedBox(
                              height: 1,
                              width: double.infinity,
                              child: const DecoratedBox(
                                  decoration:
                                      const BoxDecoration(color: Colors.grey)),
                            ),
                            SizedBox(
                              height: size.height * 0.01,
                            ),
                            //SvgPicture.asset("assets/icons/A-1.svg"),
                            Expanded(
                              child: Container(
                                height: size.height * 0.08,
                                width: size.height * 0.08,
                                // ensure the circle is in a squared box
                                //color: Colors.green,
                                child:
                                    SvgPicture.asset(product.getGradeImage()),
                                // decoration: new BoxDecoration(
                                //     shape: BoxShape.circle,
                                //     image: DecorationImage(
                                //         image:
                                //             AssetImage(product.getGradeImage()),
                                //         fit: BoxFit.cover)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
