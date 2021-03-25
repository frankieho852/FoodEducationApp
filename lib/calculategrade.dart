import 'package:food_education_app/foodproduct.dart';
import 'package:flutter/material.dart';

ScoreArray calculateGrade(FoodProduct product) {
    ScoreArray scoreArray= new ScoreArray();
  if (product.sugars_100 >= 5) {
    scoreArray.score=scoreArray.score-1;
    scoreArray.cautions.add("Too Sweet: This product contains too much sugar");
  }
  if (product.sugars_100 == 0) {
    scoreArray.score=scoreArray.score+2;
    scoreArray.checks.add("Unsweetened");
  }

  scoreArray.scoreToGrade();
  return scoreArray;
}

class ScoreArray {
  //this is a simple class to store all required information in scorepage
  String grade="C+";
  int score=5;
  List<String> checks=[];
  List<String> cautions=[];

  void scoreToGrade(){
    print(score);
    if (score<3){grade="D";}
    if (score==3){grade="C-";}
    if (score==4){grade="C";}
    if (score==5){grade="C+";}
    if (score==6){grade="B-";}
    if (score==7){grade="B";}
    if (score==8){grade="B+";}
    if (score==9){grade="A-";}
    if (score==10){grade="A";}
    if (score>10){grade="A+";}
  }
}
