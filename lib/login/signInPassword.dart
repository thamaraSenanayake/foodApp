import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';

import 'loginBase.dart';

class SignInPassword extends StatefulWidget {
  final LoginBaseListener listener;
  SignInPassword({Key key,@required this.listener}) : super(key: key);

  @override
  _SignInPasswordState createState() => _SignInPasswordState();
}

class _SignInPasswordState extends State<SignInPassword> {
  double _height;
  double _width;
  String _password = "";
  String _confirmPassword = "";

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
            Column(
              children: [
                SizedBox(
                  height: 130,
                ),
                Text(
                  "Enter your password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),

                SizedBox(
                  height: 80,
                ),

                TextBox(
                  textBoxKey: "null", 
                  onChange: (val){
                    _password = val;
                  }, 
                  errorText: "",
                  textBoxHint: "",
                ),

                SizedBox(
                  height: 30,
                ),

                Text(
                  "Re-Enter your password",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                ),

                SizedBox(
                  height: 80,
                ),

                TextBox(
                  textBoxKey: "null", 
                  onChange: (val){
                    _confirmPassword = val;
                  }, 
                  errorText: "",
                  textBoxHint: "",
                ),

              ],
            ),
            Column(
              children: [

                CustomButton(
                  text: "Next", 
                  buttonClick: (){
                    widget.listener.moveToPage(LoginPageList.SignInPhone);
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