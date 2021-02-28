
class FoodProduct {
  String name;
  String category;
  double energy=0;
  double protein=0;
  double totalFat=0;
  double saturatetedFat=0;
  double transFat=0;
  double totalCarbonhydrates=0;
  double dietarytFibre=0;
  double sugars=0;
  double sodium=0;
  String image;
  List <String> ingredients;

  FoodProduct({this.name,this.category,this.energy,this.protein,this.totalFat,this.saturatetedFat,this.transFat,this.totalCarbonhydrates,
  this.dietarytFibre,this.sugars,this.sodium,this.image,this.ingredients});

}