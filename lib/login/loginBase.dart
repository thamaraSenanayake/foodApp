import 'package:flutter/material.dart';
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
    _autoLoginCheck();
  }

  _autoLoginCheck(){

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
            Container()

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