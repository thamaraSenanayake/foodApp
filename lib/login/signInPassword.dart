import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/const.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';

import 'loginBase.dart';

class SignInPassword extends StatefulWidget {
  final LoginBaseListener listener;
  final User user;
  SignInPassword({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _SignInPasswordState createState() => _SignInPasswordState();
}

class _SignInPasswordState extends State<SignInPassword> {
  double _height;
  double _width;
  String _password = "";
  String _passwordError = "";
  String _confirmPassword = "";
  String _confirmPasswordError = "";
  bool _loading = false;

  _next() async {
    bool _validation = true;
    if(_password.isEmpty){
      setState(() {
        _passwordError = "Required Field";
      });
    }
    if(_confirmPassword.isEmpty){
      setState(() {
        _confirmPasswordError = "Required Field";
      });
    }
    if(_password !=_confirmPassword ){
      setState(() {
        _confirmPasswordError = "password isn't matched";
      });
    }
    if(_validation){
      widget.user.password = _password;
      setState(() {
        _loading = true;
      });
      //todo user availability check  
      await Database().addUser(widget.user);
      setState(() {
        _loading = false;
      });
      //todo move to home page
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
      child: Stack(
        children: [
          Container(
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
                        errorText: _passwordError,
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
                        errorText: _confirmPasswordError,
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
          ),

          _loading
            ? Container(
              color: Color.fromRGBO(128, 128, 128, 0.3),
              child: SpinKitSquareCircle(
                color: Colors.blue,
                size: 50.0,
              ),
            )
            : Container(),
        ],
      ),
    );
  }
}