import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/profile.dart';

import '../const.dart';
import 'home.dart';

class HomeBase extends StatefulWidget {
  final User user;
  HomeBase({Key key, @required this.user}) : super(key: key);

  @override
  _HomeBaseState createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  double _height;
  double _width;
  ProfilePage _profilePage = ProfilePage.Home;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: Container(
        height:_height,
        width:_width,
        child: Stack(
          children: [
            
            Container(
              height:_height,
              width:_width,
              child: Image.asset(
                AppData.BACKGROUNDPATH,
                fit:BoxFit.cover
              ),
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _width,
                height: 50,
                color: Colors.white,
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _width,
                height: 40,
                color: Colors.white,
              ),
            ),

            Container(
              height:_height,
              width:_width,
              child:SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: _width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        //  boxShadow: <BoxShadow>[
                        //   BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25)),
                        //   BoxShadow(
                        //     color: Color.fromRGBO(0, 0, 0, 0.25),
                        //     blurRadius: 12.0,
                        //     spreadRadius: 3.0,
                        //     offset: Offset(
                        //       1.0,
                        //       1.0,
                        //     ),
                        //   )
                        // ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:10),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _profilePage = ProfilePage.Profile;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: _profilePage == ProfilePage.Home ? HomePage(user: widget.user,):
                      _profilePage == ProfilePage.Profile ? Profile(user: widget.user):
                      Container()
                    ),
                    Container(
                      height: 50,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _profilePage = ProfilePage.Home;
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              color: Colors.white,
                              child: Icon(
                                Icons.home
                              ),
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.white,
                            child: Icon(
                              Icons.menu
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.white,
                            child: Icon(
                              Icons.message
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.white,
                            child: Icon(
                              Icons.add
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}