import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/const.dart';
import 'package:food_app/login/signInName.dart';
import 'package:food_app/login/signInPassword.dart';
import 'package:food_app/login/signInPhone.dart';
import 'package:food_app/login/splash.dart';
import 'package:food_app/model/user.dart';

import 'login.dart';

class LoginBase extends StatefulWidget {
  LoginBase({Key key}) : super(key: key);

  @override
  _LoginBaseState createState() => _LoginBaseState();
}

class _LoginBaseState extends State<LoginBase> implements LoginBaseListener{
  double _height;
  double _width;
  LoginPageList _page = LoginPageList.SplashScreen;
  User _user;

  @override
  void initState() {
    super.initState();
    _user = User();
    _themeSet();
  }

  _themeSet() async {
    final storage = new FlutterSecureStorage();
    String isDark = await storage.read(key: KeyContainer.IS_DARK);
    if(isDark == true.toString()){
      setState(() {
        AppData.isDarkMode = true;
        AppData.primaryColor = AppData.blackColor;
        AppData.secondaryColor =AppData.whiteColor ;
      });
    }else{
      setState(() {
        AppData.isDarkMode = false;
        AppData.primaryColor = AppData.whiteColor;
        AppData.secondaryColor =AppData.blackColor ;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: Container(
        height:_height,
        width:_width,
        color: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
        child: Stack(
          children: [
            // Container(
            //   height:_height,
            //   width:_width,
            //   child: Image.asset(
            //     AppData.BACKGROUNDPATH,
            //     fit:BoxFit.cover
            //   ),
            // ),

            _page == LoginPageList.SplashScreen?
            SplashScreen(listener: this,):
            _page == LoginPageList.Login?
            LoginPage(listener: this,):
            _page == LoginPageList.SignInName?
            SignInName(listener: this, user: _user,):
            _page == LoginPageList.SignInPhone?
            SignInPhone(listener: this, user: _user,):
            _page == LoginPageList.SignInPassword?
            SignInPassword(listener: this, user: _user,):
            Container(),

            _page != LoginPageList.SplashScreen && _page != LoginPageList.Login?
            SafeArea(
              child:  Padding(
                padding: const EdgeInsets.only(left:10.0),
                child: GestureDetector(
                  onTap: (){
                    if(_page == LoginPageList.SignInName){
                      setState(() {
                        _page = LoginPageList.Login;
                      });
                    }
                    if(_page == LoginPageList.SignInPhone){
                      setState(() {
                        _page = LoginPageList.SignInName;
                      });
                    }
                    if(_page == LoginPageList.SignInPassword){
                      setState(() {
                        _page = LoginPageList.SignInPhone;
                      });
                    }
                  },
                  child: Center(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: AppData.secondaryColor,
                      ),
                    ),
                  ),
                ),
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }

  @override
  moveToPage(LoginPageList page) {
    setState(() {
      _page = page;
    });
  }
}

abstract class LoginBaseListener{
  moveToPage(LoginPageList page);
}