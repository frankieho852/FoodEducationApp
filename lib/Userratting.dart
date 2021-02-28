import 'package:flutter/material.dart';

//grade image can be local asset, image have to store online
class Userrating {
  final String name,image;
  final double star;
  final String comment;
  Userrating({
    this.name,
    this.image,
    this.star,
    this.comment,

  });
}

List<Userrating> ratinglist = [
  Userrating(name:"Figo Liu",image:"assets/images/Vitalemontea.jpg",star:5.0,comment:"It taste sweet"),
  Userrating(name:"Figo Liu2",image:"assets/images/bread.jpg",star:1,comment:"It taste shit"),
  Userrating(name:"Figo Liu3",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
  Userrating(name:"Figo Liu4",image:"assets/images/bread.jpg",star:1.4,comment:"It taste sweet"),
  Userrating(name:"Figo Liu5",image:"assets/images/bread.jpg",star:4.1,comment:"It taste sweet"),
  Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
  Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
  Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
  Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
  Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),
  Userrating(name:"Figo Liu",image:"assets/images/bread.jpg",star:3.4,comment:"It taste sweet"),


];