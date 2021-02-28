import 'package:flutter/material.dart';

//grade image can be local asset, image have to store online
class AlternativeProduct {
  final String name,image,grade;
  final int calories;
  final double star;
  AlternativeProduct({
    this.name,
    this.grade,
    this.image,
    this.calories,
    this.star,

});
}

List<AlternativeProduct> altproducts = [
  AlternativeProduct(name:"Vita Lemon Juice",grade:"assets/images/A-minus.jpg",image:"assets/images/Vitalemontea.jpg",star:4.0,calories:200),
  AlternativeProduct(name:"A super long nameeeeeeeeeeeeeeeeeee",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.5,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread3",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread4",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:1.4,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:4.1,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),
  AlternativeProduct(name:"Whole Wheaet Bread",grade:"assets/images/A-minus.jpg",image:"assets/images/bread.jpg",star:3.4,calories:340),

];