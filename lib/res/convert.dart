import 'package:food_app/const.dart';

String categoryToString (UserCategory category){
  switch (category) {
    case UserCategory.Agriculture:
      return "Agriculture";
    case UserCategory.FoodIndustry:
      return "FoodIndustry";
    case UserCategory.Animal:
      return "Animal";
    case UserCategory.Business:
      return "Business";
    case UserCategory.Service:
      return "Service";
    case UserCategory.Education:
      return "Education";
    case UserCategory.Others:
      return "Others"; 
    default:
      return "Others";
  }
}

UserCategory stringToUserCategory (String category){
  switch (category) {
    case "Agriculture":
      return UserCategory.Agriculture;
    case "FoodIndustry":
      return UserCategory.FoodIndustry;
    case "Animal":
      return UserCategory.Animal;
    case "Business":
      return UserCategory.Business;
    case "Service":
      return UserCategory.Service;
    case "Education":
      return UserCategory.Education;
    case "Others":
      return UserCategory.Others;
    default:
      return UserCategory.Others;
  }
}

bool isNumeric(String s) {
  if(s == null) {
    return false;
  }
  return double.parse(s, (e) => null) != null;
}