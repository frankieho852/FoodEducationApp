import 'package:flutter/material.dart';
import 'package:food_education_app/foodproduct.dart';
import 'package:food_education_app/pages/DetailUserrating/components/body.dart';
import 'package:food_education_app/Userrating.dart';
class DetailUserrating extends StatelessWidget {
  final FoodProduct product;
  DetailUserrating({Key key,@required this.product}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    // todo: a function to search database by product.name -> create a list object with all comments
    List<Userrating> ratinglist = [
      Userrating(name:"Figo Liu",image:"assets/images/tempUserpicture.jpg",star:5.0,comment:"It taste sweet"),
      Userrating(name:"Figo Liu2 very long nammmmmmmmmmmmmmmmmmmme",image:"assets/images/tempUserpicture.jpg",star:1,comment:"It taste shit"),
      Userrating(name:"Figo Liu3",image:"assets/images/tempUserpicture.jpg",star:3.5,comment:"It taste ok"),
      Userrating(name:"Figo Liu4",image:"assets/images/tempUserpicture.jpg",star:1.5,comment:"Long commentIt taste sweet ddkfsdfl sdljfkdj ldd k l sljsfksjf ks kjk j ljf lkfskjslkjiwo weojejfwjfo jwjejfijfef  foefijwifwiefefifjw  wfojfw"),
      Userrating(name:"Figo Liu5",image:"assets/images/bread.jpg",star:4.1,comment:"It taste sweet"),
      Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
      Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
      Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
      Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
      Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
      Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
    ];
    return Scaffold(
      appBar: buildAppBar(product.name),
      body: Body(image:product.image,ratinglist:ratinglist,star:product.star),

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
}