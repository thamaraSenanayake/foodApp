import 'package:food_app/model/post.dart';
import 'package:food_app/model/review.dart';

import '../const.dart';

class User {
  String telNumber;
  String name;
  List<String> flowers;
  List<String> flowing;
  String email;
  String profilePicUrl;
  String password;
  String address;
  List<String> favoritePost;
  List<Review> reviewList;
  String description;
  UserCategory category;
}