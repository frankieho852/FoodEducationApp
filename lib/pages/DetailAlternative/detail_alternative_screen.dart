import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailAlternative/components/body.dart';
import 'package:food_education_app/alternativeproduct.dart';

class DetailAlternative extends StatefulWidget {
  final FoodProduct product;

  DetailAlternative({Key key, @required this.product}) : super(key: key);

  @override
  _DetailAlternativeState createState() => _DetailAlternativeState();
}

class _DetailAlternativeState extends State<DetailAlternative> {
  List<AlternativeProduct> altproductslist=[
    AlternativeProduct(name:"Vita Lemon Juice",grade:"assets/images/A-minus.jpg",image:"assets/images/Vitalemontea.jpg",star:4.0,calories:200),
  ];
  CollectionReference foodProductCollection =
      FirebaseFirestore.instance.collection('foodProduct');
  String foodProductCategory;

  void initState() {
    super.initState();
    // _setLoading(true);
    foodProductCategory = widget.product.category;
    print("in detail screen alt:"+foodProductCategory);
    _findAltproduct();
    print("in detail screen alt length:"+altproductslist.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    // todo: a function to search database by product.catergory -> create a list object with simular products

    CollectionReference foodProductCollection =
        FirebaseFirestore.instance.collection('foodProduct');


          List<AlternativeProduct> tempaltproductslist = [
            AlternativeProduct(name:"Vita TM Cold Brew No Sugar Jasmine Tea",grade:"assets/icons/A-1.svg",image:"assets/images/Vita TM Cold Brew No Sugar Jasmine Tea.jpg",star:4.0,calories:0),
            AlternativeProduct(name:"Vita TM Cold Brew No Sugar Tie Guan Yin Tea",grade:"assets/icons/A-1.svg",image:"assets/images/Vita TM Cold Brew No Sugar Jasmine Tea.jpg",star:3,calories:0),
            AlternativeProduct(name:"Vita TM Low Sugar Lemon Tea Drink",grade:"assets/icons/C-3.svg",image:"assets/images/Vitalemontea.jpg",star:3,calories:0),
            AlternativeProduct(name:"Vita TM Lemon Tea Drink",grade:"assets/icons/C-3.svg",image:"assets/images/Vita TM Lemon Tea Drink.jpg",star:4.5,calories:137),
            AlternativeProduct(name:"Vita Chrysanthemum Tea Drink",grade:"assets/icons/C-3.svg",image:"assets/images/Vita Chrysanthemum Tea Drink.jpg",star:3.4,calories:35),

          ];

    return Scaffold(
      appBar: buildAppBar(widget.product.name),
      body: Body(altproductslist: tempaltproductslist),
      //bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar(String title) {
    return AppBar(
      elevation: 0,
      title: Text(
        '$title',
        style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _findAltproduct() {
    // todo: can change to random later
    try {
      var getaltproduct = foodProductCollection.where('category',
          isEqualTo: foodProductCategory);

      getaltproduct.get().then((value) {
        for (DocumentSnapshot document in value.docs) {
          altproductslist.add(AlternativeProduct(
              name: document.data()["name"], image: document.data()["image"],calories:document.data()["energy"],grade: document.data()["energy"] ));
        }
      });
    } on StateError catch (e) {
      print("Error: findAltproduct");
    }
  }
}
