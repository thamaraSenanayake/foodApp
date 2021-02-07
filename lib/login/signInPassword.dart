import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';
import 'package:food_app/profile/homeBase.dart';

import '../const.dart';
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
      _validation = false;
    }
    if(_confirmPassword.isEmpty){
      setState(() {
        _confirmPasswordError = "Required Field";
      });
      _validation = false;
    }
    if(_password !=_confirmPassword ){
      setState(() {
        _confirmPasswordError = "password isn't matched";
      });
      _validation = false;
    }
    if(_validation){
      widget.user.password = _password;
      setState(() {
        _loading = true;
      });
      //todo user availability check  
      await Database().addUser(widget.user);
      User _user =  await Database().getUser(widget.user.telNumber);
      final storage = new FlutterSecureStorage();
      storage.write(key: KeyContainer.USERNAME,value:widget.user.telNumber);
      storage.write(key: KeyContainer.PASSWORD,value: widget.user.password);
      setState(() {
        _loading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeBase(
            user: _user,
          )
        )
      );
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
                        height: 10,
                      ),
                      Text(
                        "Enter your password",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),

                      Text(
                        _passwordError,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15
                        ),
                      ),

                      TextBox(
                        textBoxKey: "null", 
                        onChange: (val){
                          _password = val;
                          setState(() {
                            _passwordError = "";
                          });
                        }, 
                        errorText: _passwordError,
                        textBoxHint: "",
                        obscureText: true,
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
                        height: 40,
                      ),
                      Text(
                        _passwordError,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15
                        ),
                      ),

                      Text(
                        _confirmPasswordError,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15
                        ),
                      ),

                      TextBox(
                        textBoxKey: "null", 
                        onChange: (val){
                          _confirmPassword = val;
                          setState(() {
                            _confirmPasswordError = "";
                          });
                        }, 
                        errorText: _confirmPasswordError,
                        textBoxHint: "",
                        obscureText: true,
                      ),

                    ],
                  ),
                  Column(
                    children: [

                      CustomButton(
                        text: "Sign in", 
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
                color: AppData.thirdColor,
                size: 50.0,
              ),
            )
            : Container(),
        ],
      ),
    );
  }
}