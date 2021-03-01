// the following values are total value, not /100g value
// OCR process: Scan -> input total volume -> calculate total nutrients values -> store
class FoodProduct {
  String name;
  String category;
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
  final int calories;
  final double star;

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
      this.calories});
}
