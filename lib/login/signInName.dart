import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';

import 'loginBase.dart';

class SignInName extends StatefulWidget {
  final LoginBaseListener listener;
  final User user;
  SignInName({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _SignInNameState createState() => _SignInNameState();
}

class _SignInNameState extends State<SignInName> {
  double _height;
  double _width;
  String _name = "";
  String _nameError = "";

  _next(){
    if(_name.isEmpty){
      setState(() {
        _nameError = "Required Field";
      });
    }else{
      widget.user.name = _name;
      widget.listener.moveToPage(LoginPageList.SignInPhone);
    }
  }


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
                  "Enter your name or business name",
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
                    _name = val;
                  }, 
                  errorText: _nameError,
                  textBoxHint: "",
                ),

              ],
            ),
            Column(
              children: [

                CustomButton(
                  text: "Next", 
                  buttonClick: (){
                    _next();
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