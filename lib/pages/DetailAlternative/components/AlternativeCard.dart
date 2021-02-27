import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
//import 'package:flutter/cupertino.dart';
import 'package:food_education_app/AlternativeProduct.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class AlternativeCard extends StatelessWidget {
  const AlternativeCard({
    Key key,
    this.product,
    this.press,
  }) : super(key: key);

  final AlternativeProduct product;
  final Function press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //width: size.width * 0.3,
      height: size.height*0.18,
      //color: Colors.grey,
      child: Card(
        elevation: 0,
        //color: Colors.blue,
        child: InkWell(
          onTap: (){},
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(kDefaultPadding*0.1),
                height: size.height*0.14,
                width: size.width*0.35,
                decoration: BoxDecoration(
                  //color: Colors.red,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18.0),
                  child: Image.asset(product.image,fit: BoxFit.cover,),
                )
              ),
              SizedBox(width: size.width*0.03,),
              Expanded(//the width is expanded
                child: Container(
                  padding: EdgeInsets.all(kDefaultPadding*0.1),
                  height: size.height*0.14,
                  //color: Colors.red,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                          height: size.height*0.04,
                          //color: Colors.lightGreenAccent,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              product.name,
                              style: TextStyle(
                                fontSize:  size.width*0.04,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                            height: size.height*0.04,
                            //color: Colors.lightGreenAccent,
                            child: Row(
                              children: [
                                Text(
                                  product.star.toString(),
                                  style: TextStyle(
                                    fontSize:  size.width*0.04,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  width: size.width*0.01,
                                ),
                                RatingBar(
                                  initialRating: product.star,
                                  ratingWidget: RatingWidget(
                                    full: Icon(Icons.star,color: kPrimaryColor,),
                                    half: Icon(Icons.star_half,color: kPrimaryColor,),
                                    empty: Icon(Icons.star_border,color: kPrimaryColor,)
                                  ),
                                  itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                                  allowHalfRating: true,
                                  itemSize: size.width*0.04,
                                  onRatingUpdate: (rating) {
                                    print(rating);
                                  },
                                )
                              ],
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Container(
                            height: size.height*0.04,
                           // color: Colors.lightGreenAccent,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product.calories.toString()+" Calories",
                                style: TextStyle(
                                  fontSize:  size.width*0.035,//slightly smaller than product name and star
                                  //fontWeight: FontWeight.bold, no bold here
                                ),
                                softWrap: false,
                              ),
                            )
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
