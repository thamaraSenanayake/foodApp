import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';

import '../../const.dart';


class SettingsScreen extends StatefulWidget {
  final User user;
  final Function logout;
  SettingsScreen({Key key,@required this.user,@required this.logout}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>  {
  double _width = 0.0;
  double _height = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body: Container(
        width : _width,
        height :_height,
        child: SafeArea(
          child: Column(
            children: [

              //header
              Column(
                children: [
                  Container(
                    width : _width,
                    height: 50,
                    // color: Colors.red,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Settings",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 100,
              ),

              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Dark Theme",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.brightness_low
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Choose the language",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.language_outlined
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Privacy policy",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.privacy_tip
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Rate us",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.rate_review_sharp
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "About",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.info
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      onTap: (){
                        Navigator.pop(context);
                        widget.logout();
                      },
                      title: Text(
                        "Logout",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20
                        ),
                      ),
                      trailing: Icon(
                        Icons.add_to_home_screen
                      ),
                    ),
                  ),
                ],
              ),

              Container()

            ],
          ),
        ),
      ),
    );
  }

}