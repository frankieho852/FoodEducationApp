import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/constants.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailScore/detail_score_screen.dart';

class Header extends StatelessWidget {
  Header({
    Key key,
    @required this.size,
    @required this.product,
    @required this.scoreArray,
  }) : super(key: key);

  final Size size;
  final FoodProduct product;
  final ScoreArray scoreArray;
  final FoodProduct FoodProduct2 = new FoodProduct();

  @override
  Widget build(BuildContext context) {

    CollectionReference foodProductCollection =
    FirebaseFirestore.instance.collection('foodProduct');

    ///// Add strembuilder ///
    return StreamBuilder<DocumentSnapshot>(
      stream: foodProductCollection.doc("Temp milk").snapshots(), //_getProdcutData(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Container(
            alignment: Alignment.center,
            child: Text('Error'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator()
          );
        }



        /*
            // foodProductCategory = snapshot.get("category");
            FoodProduct2.copy(FoodProduct(
                name: snapshot.get("name"),
                category: snapshot.get("category"),
                volumeOrweight: snapshot.get("volumeOrweight").toDouble(),
                energy: snapshot.get("energy").toDouble(),
                protein: snapshot.get("protein").toDouble(),
                totalFat: snapshot.get("totalFat").toDouble(),
                saturatedFat: snapshot.get("saturatedFat").toDouble(),
                transFat: snapshot.get("transFat").toDouble(),
                carbohydrates: snapshot.get("carbohydrates").toDouble(),
                dietarytFibre: snapshot.get("dietarytFibre").toDouble(),
                sugars: snapshot.get("sugars").toDouble(),
                sodium: snapshot.get("sodium").toDouble(),
                image: snapshot.get("image"),
                grade: snapshot.get("grade"),
                ingredients: new List<String>.from(snapshot.data()["ingredients"]),
                //snapshot.data()["ingredients"],//List.castFrom(snapshot.data()["ingredients"]), //
                star: snapshot.get("star").toDouble()));

         */


        return _showHeader(context);
      }
    );

    //////////////////////////
  }

  Widget _showHeader(context){

    //SizeConfig().init(context);// this is important for using proportionatescreen function
    return Container(
      // explanation: margin between this container and "Recommended section title

      // explanation: height of the wrapping container, including the daily target card
      height: size.height * 0.2,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: kDefaultPadding,
              right: kDefaultPadding,
              // Bottom padding not affecting the UI
              bottom: 36 + kDefaultPadding,
            ),
            // explanation: minus 27 to lift this container away up from the wrapping container
            height: size.height * 0.2 - 27,
            decoration: BoxDecoration(
              color: kPrimaryColor,
              // location: the bottom corner of the teal header block
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(14),
                bottomRight: Radius.circular(14),
              ),
            ),
          ),
          Positioned(
              top: 10,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                padding: EdgeInsets.symmetric(horizontal: kDefaultPadding / 10),
                height:
                size.height * 0.18, //use dynamic value(change by figo 25/2)
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
                            scoreArray: this.product.calculateGrade(),
                          ))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: size.height * 0.2,
                          width: size.width * 0.4,
                          //color: Colors.green,
                          decoration: new BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.grey.withOpacity(0.3)),
                              borderRadius: BorderRadius.circular(14),
                              image: DecorationImage(
                                //todo: add picture
                                  image: AssetImage("assets/images/Vita TM Lemon Tea Drink.jpg"),
                                  fit: BoxFit.fitHeight)),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            //color: Colors.red,
                            padding: const EdgeInsets.only(left:8.0,right:8.0),
                            decoration: new BoxDecoration(
                              color: Color(0xFFF6FAF9),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(height: 8.0,),
                                Flexible(
                                  child: Container(
                                    height: size.height*0.05,
                                    child: FittedBox(
                                      child: Text(
                                        "Is this product"+"\n"+"good for you?",
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 8.0,
                                ),
                                Expanded(
                                  child: Container(
                                    height: size.height*0.06,
                                    width: double.infinity,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: double.infinity,
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(14),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(left: 4,right: 4),
                                              color: Colors.transparent,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: size.height * 0.025,
                                                        child: FittedBox(
                                                          fit: BoxFit.fitHeight,
                                                          child: Text(
                                                            scoreArray.checks
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: kPrimaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width:2),
                                                      Icon(
                                                        Icons.check,
                                                        color: kPrimaryColor,
                                                        size: size.height * 0.025,
                                                      ),
                                                    ],
                                                  ),
                                                  Flexible(child:SizedBox(height:4)),
                                                  Container(
                                                    height: size.height*0.025,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text(
                                                        "Checks",
                                                        style: TextStyle(
                                                          color: kPrimaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4,),
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                            height: double.infinity,
                                            decoration: new BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.circular(14),
                                            ),
                                            child: Container(
                                              margin: EdgeInsets.only(left: 4,right: 4),
                                              color: Colors.transparent,
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                    children: [
                                                      Container(
                                                        height: size.height * 0.025,
                                                        child: FittedBox(
                                                          fit: BoxFit.fitHeight,
                                                          child: Text(
                                                            scoreArray.cautions
                                                                .toString(),
                                                            style: TextStyle(
                                                              color: Colors.orange,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(width:2),
                                                      Icon(
                                                        Icons.dangerous,
                                                        color: Colors.orange,
                                                        size: size.height * 0.025,
                                                      ),
                                                    ],
                                                  ),
                                                  Flexible(child:SizedBox(height:4)),
                                                  Container(
                                                    height: size.height*0.025,
                                                    child: FittedBox(
                                                      fit: BoxFit.fitHeight,
                                                      child: Text(
                                                        "Cautions",
                                                        style: TextStyle(
                                                          color: Colors.orange,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.0,),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Future<FoodProduct> _getProdcutData() async {

    CollectionReference foodProductCollection =
    FirebaseFirestore.instance.collection('foodProduct');
    try {
      await foodProductCollection.doc("Temp milk").get().then((snapshot) {
       // foodProductCategory = snapshot.get("category");
        FoodProduct2.copy(FoodProduct(
            name: snapshot.get("name"),
            category: snapshot.get("category"),
            volumeOrweight: snapshot.get("volumeOrweight").toDouble(),
            energy: snapshot.get("energy").toDouble(),
            protein: snapshot.get("protein").toDouble(),
            totalFat: snapshot.get("totalFat").toDouble(),
            saturatedFat: snapshot.get("saturatedFat").toDouble(),
            transFat: snapshot.get("transFat").toDouble(),
            carbohydrates: snapshot.get("carbohydrates").toDouble(),
            dietarytFibre: snapshot.get("dietarytFibre").toDouble(),
            sugars: snapshot.get("sugars").toDouble(),
            sodium: snapshot.get("sodium").toDouble(),
            image: snapshot.get("image"),
            grade: snapshot.get("grade"),
            ingredients: new List<String>.from(snapshot.data()["ingredients"]),
            //snapshot.data()["ingredients"],//List.castFrom(snapshot.data()["ingredients"]), //
            star: snapshot.get("star").toDouble()));
      });
      return FoodProduct2;
    } on StateError catch (e) {
      print("Error-getproduct:  " + e.message);
      //   return false;
    } finally {
      //_setLoading(false);
      //print();
    }
    //  return true;
  }
}
