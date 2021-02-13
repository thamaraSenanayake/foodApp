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
  static Color blackColor= Color(0xff393939);
  static Color primaryColor= Color(0xFFFFFBFB);
  static Color whiteColor= Color(0xFFFFFBFB);
  static Color thirdColor = Color(0xFFFF7D05);
  static int reviewCount = 0;
  static int clapCount = 0;
  static int msgCount = 0;
  static bool isDarkMode = false;

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
  ProductList
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