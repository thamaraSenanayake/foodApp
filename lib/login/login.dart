import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/const.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';
import 'package:food_app/profile/homeBase.dart';

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
  String _phoneNumberError = "";
  String _password = "";
  String _passwordError = "";
  String _loginError = "";
  bool _loading = false;

  _login() async {
    bool validation = true;
    User user;
    print("login");
    if( _phoneNumber.isEmpty) {
      setState(() {
        _phoneNumberError = "Required field";
      });
      validation = false;
    }
    if( _password.isEmpty) {
      setState(() {
        _passwordError = "Required field";
      });
      validation = false;
    }

    if(validation){

      setState(() {
        _loading = true;
      });
      user = await Database().login(_phoneNumber, _password);
      setState(() {
        _loading = false;
      });

      if(user == null){
        _loginError = "Invalid login details";
      }else{
        _loginError = "valid login";
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeBase(
              user: user,
            )
          )
        );
      }
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
                        child: Text(
                          _phoneNumberError,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15
                          ),
                        ),
                      ),

                      TextBox(
                        textBoxKey: "null", 
                        onChange: (val){
                          setState(() {
                            _phoneNumber = val;
                            _phoneNumberError = "";
                          });
                        }, 
                        errorText: _phoneNumberError,
                        textBoxHint: "Phone Number",
                        prefixIcon: Icons.phone,
                      ),

                      SizedBox(
                        height: 20,
                        child: Text(
                          _passwordError,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15
                          ),
                        ),
                      ),


                      TextBox(
                        textBoxKey: "null", 
                        onChange: (val){
                          setState(() {
                            _password = val;
                            _passwordError = "";
                          });
                        }, 
                        errorText: _passwordError,
                        textBoxHint: "Password",
                        prefixIcon: Icons.lock,
                        obscureText: true,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        _loginError,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 15
                        ),
                      ),
                      CustomButton(
                        text: "Login", 
                        buttonClick: (){
                          _login();
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