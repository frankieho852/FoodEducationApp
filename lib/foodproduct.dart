// the following values are total value, not /100g value
// OCR process: Scan -> input total volume -> calculate total nutrients values -> store
class FoodProduct {
  String name;
  String category;
  double volumeOrweight;

  double energy = 0;
  double protein = 0;
  double totalFat = 0;
  double saturatetedFat = 0;
  double transFat = 0;
  double carbohydrates = 0;
  double dietarytFibre = 0;
  double sugars = 0;
  double sodium = 0;

  double energy_100 = 0;
  double protein_100 = 0;
  double totalFat_100 = 0;
  double saturatetedFat_100 = 0;
  double transFat_100 = 0;
  double carbohydrates_100 = 0;
  double dietarytFibre_100 = 0;
  double sugars_100 = 0;
  double sodium_100 = 0;

  String image;
  String grade;
  List<String> ingredients;

  double star = 0; //average rating by users

  FoodProduct({
    this.name,
    this.category,
    this.volumeOrweight,
    this.energy,
    this.protein,
    this.totalFat,
    this.saturatetedFat,
    this.transFat,
    this.carbohydrates,
    this.dietarytFibre,
    this.sugars,
    this.sodium,
    this.energy_100,
    this.protein_100,
    this.totalFat_100,
    this.saturatetedFat_100,
    this.transFat_100,
    this.carbohydrates_100,
    this.dietarytFibre_100,
    this.sugars_100,
    this.sodium_100,
    this.image,
    this.ingredients,
    this.grade,
    this.star,
  });

  ScoreArray calculateGrade() {//this function will calculate grade and change this.product.grade and return a score array object
    ScoreArray scoreArray = new ScoreArray();
    if (this.sugars_100 >= 5) {
      scoreArray.score = scoreArray.score - 1;
      scoreArray.cautions
          .add("Too Sweet: This product contains too much sugar");
    }
    if (this.sugars_100 == 0) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.checks.add("Unsweetened");
    }
    if (this.totalFat_100 > -1) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.checks.add(
          "Temp +1 check xxxsxsxsxsxscjsadhckjsdhfksjdfjlasdsfjdshfjklshfdsjkfhdslfshdflskjhfd");
    }
    if (this.totalFat_100 > -1) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.checks.add("Temp +2 check");
    }
    if (this.totalFat_100 > -1) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.cautions.add("Temp +1 caution");
    }
    if (this.totalFat_100 > -1) {
      scoreArray.score = scoreArray.score + 2;
      scoreArray.cautions.add("Temp +2 caution");
    }
    this.grade = scoreArray.scoreToGrade();
    return scoreArray;
  }

  String getGradeImage() {
    String gradeimage;
    print("calling getGradeImage() "+grade); //testing
    if (grade == "A") {
      gradeimage = "assets/images/A-minus.jpg";
    }
    if (grade == "B") {
      gradeimage = "assets/images/B.jpg";
    }
    if (grade == "C") {
      gradeimage = "assets/images/A-minus.jpg";
    }
    if (grade == "D") {
      gradeimage = "assets/images/D.jpg";
    }
    return gradeimage;
  }

  void calculateTotalNutrient() {
    if (this.energy == null) {
      this.energy = this.energy_100 * this.volumeOrweight / 100;
      this.protein = this.protein_100 * this.volumeOrweight / 100;
      this.totalFat = this.totalFat_100 * this.volumeOrweight / 100;
      this.saturatetedFat = this.saturatetedFat_100 * this.volumeOrweight / 100;
      this.transFat = this.transFat_100 * this.volumeOrweight / 100;
      this.carbohydrates = this.carbohydrates_100 * this.volumeOrweight / 100;
      this.dietarytFibre = this.dietarytFibre_100 * this.volumeOrweight / 100;
      this.sugars = this.sugars_100 * this.volumeOrweight / 100;
      this.sodium = this.sodium_100 * this.volumeOrweight / 100;
    }
    if (this.energy_100 == null) {
      this.energy_100 = this.energy/this.volumeOrweight;
      this.protein_100 = this.protein / this.volumeOrweight;
      this.totalFat_100 = this.totalFat / this.volumeOrweight;
      this.saturatetedFat_100 = this.saturatetedFat / this.volumeOrweight;
      this.transFat_100 = this.transFat / this.volumeOrweight;
      this.carbohydrates_100 = this.carbohydrates / this.volumeOrweight;
      this.dietarytFibre_100 = this.dietarytFibre / this.volumeOrweight;
      this.sugars_100 = this.sugars / this.volumeOrweight;
      this.sodium_100 = this.sodium/ this.volumeOrweight;
    }
  }

  double getNutrientDouble(String temp) {
    double result = -1;
    if (temp == "energy") {
      result = this.energy;
    }
    if (temp == "protein") {
      result = this.protein;
    }
    if (temp == "totalFat") {
      result = this.totalFat;
    }
    if (temp == "saturatedFat") {
      result = this.saturatetedFat;
    }
    if (temp == "transFat") {
      result = this.transFat;
    }
    if (temp == "carbohydrates") {
      result = this.carbohydrates;
    }
    if (temp == "sugars") {
      result = this.sugars;
    }
    if (temp == "sodium") {
      result = this.sodium;
    }
    return result;
  }

  String getNutrientImage(String temp) {
    String result = "not found";
    if (temp == "energy") {
      result = "assets/images/caloriesicon.jpg";
    }
    if (temp == "protein") {
      result = "assets/images/proteinicon.jpg";
    }
    if (temp == "totalFat") {
      result = "assets/images/caloriesicon.jpg";
    }
    if (temp == "saturatedFat") {
      result = "assets/images/caloriesicon.jpg";
    }
    if (temp == "transFat") {
      result = "assets/images/caloriesicon.jpg";
    }
    if (temp == "carbohydrates") {
      result = "assets/images/caloriesicon.jpg";
    }
    if (temp == "sugars") {
      result = "assets/images/caloriesicon.jpg";
    }
    if (temp == "sodium") {
      result = "assets/images/caloriesicon.jpg";
    }
    return result;
  }

  void printproduct(){
    print("printing "+ this.name + '\n');

    print(this.energy.toString()+'\n');
    print(this.protein.toString()+'\n');
    print(this.totalFat.toString()+'\n');
    print(this.saturatetedFat.toString()+'\n');
    print(this.transFat.toString()+'\n');
    print(this.carbohydrates.toString()+'\n');
    print(this.dietarytFibre.toString()+'\n');
    print(this.sugars.toString()+'\n');
    print(this.sodium.toString()+'\n');
    print("printing 100: "+ this.name + '\n');
    print(this.energy_100.toString()+'\n');
    print(this.protein_100.toString()+'\n');
    print(this.totalFat_100.toString()+'\n');
    print(this.saturatetedFat_100.toString()+'\n');
    print(this.transFat_100.toString()+'\n') ;
    print(this.carbohydrates_100.toString()+'\n');
    print(this.dietarytFibre_100.toString()+'\n');
    print(this.sugars_100.toString()+'\n');
    print(this.sodium_100.toString()+'\n');
  }
}

class ScoreArray {
  //this is a simple class to store all required information in scorepage
  String grade = "C";
  int score = 6;
  List<String> checks = [];
  List<String> cautions = [];

  String scoreToGrade() {
    print("calling scoreToGrade score="+score.toString());
    if (score < 3) {
      grade = "D";
    }
    if (score > 3) {
      grade = "C";
    }
    if (score > 6) {
      grade = "B";
    }
    if (score > 9) {
      grade = "A";
    }
    return grade;
  }
}
