import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';

import 'loginBase.dart';

class SignInPhone extends StatefulWidget {
  final LoginBaseListener listener;
  final User user;

  SignInPhone({Key key,@required this.listener,@required this.user}) : super(key: key);

  @override
  _SignInPhoneState createState() => _SignInPhoneState();
}

class _SignInPhoneState extends State<SignInPhone> {
  double _height;
  double _width;
  String _phone = "";
  String _phoneError = "";

  _next(){
    if(_phone.isEmpty){
      setState(() {
        _phoneError = "Required Field";
      });
    }else{
      widget.user.telNumber = _phone;
      widget.listener.moveToPage(LoginPageList.SignInPassword);
    }
  }
  @override
  void initState() { 
    super.initState();
    _phone = widget.user.telNumber != null?widget.user.telNumber:'';
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
                  "Enter your phone number",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppData.secondaryColor,
                  ),
                ),

                SizedBox(
                  height: 60,
                ),

                Text(
                  _phoneError,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15
                  ),
                ),

                TextBox(
                  initText: _phone,
                  textInputType:TextInputType.phone,
                  textBoxKey: "null", 
                  onChange: (val){
                    _phone = val;
                    setState(() {
                      _phoneError = "";
                    });
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