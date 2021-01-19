import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';

import 'loginBase.dart';

class LoginPage extends StatefulWidget {
  final LoginBaseListener listener;
  LoginPage({Key key,@required this.listener}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _height;
  double _width;
  String _phoneNumber = "";
  String _password = "";

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
            Container(),
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

                TextBox(
                  textBoxKey: "null", 
                  onChange: (val){

                  }, 
                  errorText: "",
                  textBoxHint: "Phone Number",
                  prefixIcon: Icons.phone,
                ),

                SizedBox(
                  height: 20,
                ),


                TextBox(
                  textBoxKey: "null", 
                  onChange: (val){

                  }, 
                  errorText: "",
                  textBoxHint: "Password",
                  prefixIcon: Icons.lock,
                  obscureText: true,
                ),
              ],
            ),
            Column(
              children: [

                CustomButton(
                  text: "Login", 
                  buttonClick: (){

                  }
                ),

                SizedBox(
                  height: 20,
                ),

                CustomButton(
                  text: "Create a New Account", 
                  buttonClick: (){
                    widget.listener.moveToPage(LoginPageList.SignInName);
                  }
                ),

              ],
            ),
          ],
         ),
       ),
    );
  }
}