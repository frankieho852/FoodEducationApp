
//this class is just used for building up the searching page without backend, in later stage after we link the app with AWS backend
//we will directly call the http request to get the resources needed
class FoodProduct {
  String name;
  double energy=0;
  double protein=0;
  double totalFat=0;
  double saturatetedFat=0;
  double transFat=0;
  double totalCarbonhydrates=0;
  double dietarytFibre=0;
  double sugars=0;
  double sodium=0;

  FoodProduct({this.name,this.energy,this.protein,this.totalFat,this.saturatetedFat,this.transFat,this.totalCarbonhydrates,
  this.dietarytFibre,this.sugars,this.sodium});

}