import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/const.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/profile/homeBase.dart';

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
  bool _checking = true;

  _autoLogin() async {
    final storage = new FlutterSecureStorage();
    String username = await storage.read(key: KeyContainer.USERNAME);
    String password = await storage.read(key: KeyContainer.PASSWORD);
    print(username);
print(password);
    if(username != null && password != null){
      User user =await Database().login(username, password);

      if(user != null){
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
    setState(() {
      _checking = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _autoLogin();
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
            RichText(
              textAlign: TextAlign.center,
              text:TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'my',
                    style:TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue
                    )
                  ),
                  TextSpan(
                    text: ' POCKET',
                    style:TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow[800]
                    )
                  ),
                ],
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
                RichText(
                  textAlign: TextAlign.center,
                  text:TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: "Welcome to ",
                        style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          color: AppData.secondaryColor
                        )
                      ),
                      TextSpan(
                        text: 'my',
                        style:TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                        )
                      ),
                      TextSpan(
                        text: ' POCKET',
                        style:TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow[800]
                        )
                      ),
                    ],
                  ),
                ),
              ],
            ),

            _checking?Container(
              height: 50,
              width: _width-120,
              child:SpinKitSquareCircle(
                color: AppData.thirdColor,
                size: 50.0,
              ),
            ): CustomButton(
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