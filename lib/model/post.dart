import 'package:food_app/model/user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Post{
  String id;
  String userTelNumber;
  String title;
  String place;
  String city;
  LatLng location;
  double price;
  int qty;
  String amount;
  DateTime intendDate;
  DateTime insertTime;
  String description;
  String imgUrl;
  List<User> clapUser;
  bool forSale;

}