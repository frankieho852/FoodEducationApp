// the following values are total value, not /100g value
// OCR process: Scan -> input total volume -> calculate total nutrients values -> store
class FoodProduct {
  String name;
  String category;
  double volume;

  double energy = 0;
  double protein = 0;
  double totalFat = 0;
  double saturatetedFat = 0;
  double transFat = 0;
  double totalCarbonhydrates = 0;
  double dietarytFibre = 0;
  double sugars = 0;
  double sodium = 0;

  double energy_100 = 0;
  double protein_100 = 0;
  double totalFat_100 = 0;
  double saturatetedFat_100 = 0;
  double transFat_100 = 0;
  double totalCarbonhydrates_100 = 0;
  double dietarytFibre_100 = 0;
  double sugars_100 = 0;
  double sodium_100 = 0;

  String image;
  String grade;
  List<String> ingredients;

  double star=0; //average rating by users

  FoodProduct(
      {this.name,
      this.category,

      this.energy,
      this.protein,
      this.totalFat,
      this.saturatetedFat,
      this.transFat,
      this.totalCarbonhydrates,
      this.dietarytFibre,
      this.sugars,
      this.sodium,

      this.energy_100,
      this.protein_100,
      this.totalFat_100,
      this.saturatetedFat_100,
      this.transFat_100,
      this.totalCarbonhydrates_100,
      this.dietarytFibre_100,
      this.sugars_100,
      this.sodium_100,
      this.image,
      this.ingredients,
      this.grade,
      this.star,
     });

  ScoreArray calculateGrade() {
    ScoreArray scoreArray= new ScoreArray();
    if (this.sugars_100 >= 5) {
      scoreArray.score=scoreArray.score-1;
      scoreArray.cautions.add("Too Sweet: This product contains too much sugar");
    }
    if (this.sugars_100 == 0) {
      scoreArray.score=scoreArray.score+2;
      scoreArray.checks.add("Unsweetened");
    }
    if (this.totalFat_100 > -1) {
      scoreArray.score=scoreArray.score+2;
      scoreArray.checks.add("Temp +1 check xxxsxsxsxsxscjsadhckjsdhfksjdfjlasdsfjdshfjklshfdsjkfhdslfshdflskjhfd");
    }
    if (this.totalFat_100 > -1) {
      scoreArray.score=scoreArray.score+2;
      scoreArray.checks.add("Temp +2 check");
    }
    if (this.totalFat_100 > -1) {
      scoreArray.score=scoreArray.score+2;
      scoreArray.cautions.add("Temp +1 caution");
    }
    if (this.totalFat_100 > -1) {
      scoreArray.score=scoreArray.score+2;
      scoreArray.cautions.add("Temp +2 caution");
    }
    this.grade=scoreArray.scoreToGrade();
    return scoreArray;
  }

  String getGradeImage(){
    String gradeimage;
    print(grade);//testing
    if (grade=="A"){gradeimage="assets/images/A-minus.jpg";}
    if (grade=="B"){gradeimage="assets/images/B.jpg";}
    if (grade=="C"){gradeimage="assets/images/A-minus.jpg";}
    if (grade=="D"){gradeimage="assets/images/D.jpg";}
    return gradeimage;
  }
  void calculateTotalNutrient(){
    this.energy=this.energy_100*this.volume;
    this.protein=this.protein_100*this.volume;
    this.totalFat=this.totalFat_100*this.volume;
    this.saturatetedFat=this.saturatetedFat_100*this.volume;
    this.transFat=this.transFat_100*this.volume;
    this.totalCarbonhydrates=this.totalCarbonhydrates_100*this.volume;
    this.dietarytFibre=this.dietarytFibre_100*this.volume;
    this.sugars=this.sugars_100*this.volume;
    this.sodium=this.sodium_100*this.volume;

  }

  String getnutrient(){return "xd";}
}



class ScoreArray {
  //this is a simple class to store all required information in scorepage
  String grade="C+";
  int score=6;
  List<String> checks=[];
  List<String> cautions=[];

  String scoreToGrade(){
    print(score);
    if (score<3){grade="D";}
    if (score>3){grade="C";}
    if (score>6){grade="B";}
    if (score>9){grade="A";}
    return grade;
  }
}