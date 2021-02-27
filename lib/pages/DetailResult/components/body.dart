import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'header.dart';
import 'Nutritionbox.dart';
import 'package:food_education_app/pages/DetailResult/foodproduct.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    FoodProduct tempfood = FoodProduct(
        name: "Quick Serve Macaroni",
        protein: 1,
        totalFat: 2,
        totalCarbonhydrates: 12,
        energy: 210);
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size),
          SizedBox(height:size.height*0.02),
          NutritionBox(size: size,product: tempfood,),
          Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Container(
                            height: size.height*0.2,
                            width: size.width*0.5,
                            child: InkWell(
                              // onTap: () =>Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => DetailedAlternative(temp2food: tempfood,)
                              //     )),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(Radius.circular(16.0))

                                ),

                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text("Alternatives"),
                                    ),
                                    SizedBox(
                                      height: 0.5,
                                      width: size.width*0.2,
                                      child: const DecoratedBox(
                                        decoration: const BoxDecoration(color: Colors.grey),
                                      ),
                                    )
                                  ],
                                ),
                              ),

                            ),
                          ),
                          SizedBox(
                            width: size.width*0.1,
                          ),
                          Column(
                            children: [
                              Container(
                                height:size.height*0.1,
                                width:size.width*0.3,
                                child: InkWell(
                                  // onTap: () =>Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => DetailedUserrating()
                                  //     )),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: const BorderRadius.all(Radius.circular(16.0))
                                    ),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text("User Rating"),
                                          ),
                                          SizedBox(
                                            height: 0.5,
                                            width: size.width*0.2,
                                            child: const DecoratedBox(
                                                decoration: const BoxDecoration(color: Colors.grey)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height:size.height*0.1,
                                width:size.width*0.3,
                                child: InkWell(
                                  // onTap: () =>Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => DetailedScore()
                                  //     )),
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                                    ),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Text("Score"),
                                          ),
                                          SizedBox(
                                            height: 0.5,
                                            width: size.height*0.1,
                                            child: const DecoratedBox(decoration: const BoxDecoration(color: Colors.grey)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.asset('assets/image/A-minus.jpg',height: size.height*0.1,width: size.width*0.1,),
                                          )//temp use
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )
        ],
      ),
    );
  }
}
