import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/module/customButton.dart';

import 'loginBase.dart';

class SplashScreen extends StatefulWidget {
  final LoginBaseListener listener;
  SplashScreen({Key key,@required this.listener}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
      height:_height,
      width:_width,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppData.APPNAME,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),
            ),
            
            Column(
              children: [
                Container(
                  height: 200,
                  child: Image.asset(
                    AppData.LOGOPATH
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Welcome to "+AppData.APPNAME,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),

            CustomButton(
              text: "Next", 
              buttonClick: (){
                widget.listener.moveToPage(LoginPageList.Login);
              }
            ),
            
          ],
         ),
       ),
    );
  }
}