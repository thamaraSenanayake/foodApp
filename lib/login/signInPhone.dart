import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';

import 'loginBase.dart';

class SignInPhone extends StatefulWidget {
  final LoginBaseListener listener;
  SignInPhone({Key key,@required this.listener}) : super(key: key);

  @override
  _SignInPhoneState createState() => _SignInPhoneState();
}

class _SignInPhoneState extends State<SignInPhone> {
  double _height;
  double _width;
  String _phone = "";

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
                  "Enter your phone number",
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
                    _phone = val;
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
                    widget.listener.moveToPage(LoginPageList.SignInPassword);
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