// the following values are total value, not /100g value
// Data input process: Take photo of a food product -> Barcode Scan -> ORC scan ingredient list -> input total volume -> input per100 gram values(ocr table not working)
// ->calculate total nutrients values by 100values and total volume -> calculate grade ->store

class FoodProduct {
  String name; //used for search product by name
  String category; //used in alternatives
  String barcode; //used for search product by barcode
  String image;
  String grade;

  double volumeOrweight;

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

  List<String> ingredients;

  double star = 0; //average rating by users, default 0 when no user ratting, whenever user update a userratting, this value have to update

  FoodProduct({
    this.name,
    this.category,
    this.barcode,
    this.grade,
    this.image,
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
    this.ingredients,
    this.star,
  });
}
