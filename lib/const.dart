import 'dart:ui';

enum LoginPageList{
  SplashScreen,
  Login,
  SignInName,
  SignInPassword,
  SignInPhone
}

class AppData{
  static const String LOGOPATH = 'assets/images/logo.png';
  static const String BACKGROUNDPATH = 'assets/images/background.jpg';
  static Color secondaryColor= Color(0xff393939);
  static Color primaryColor= Color(0xFFFFFBFB);
}

enum UserCategory{
  Agriculture,
  FoodIndustry,
  Animal,
  Business,
  Service,
  Education,
  Others,
}
enum EditType{
  Name,
  Address,
  Email,
  Description,
}

enum ProfilePage{
  Profile,
  Search,
  Home,
  Category,
  Message,
  Add
}

class KeyContainer {
  static const String USERNAME = 'username';
  static const String PASSWORD = 'password';
}