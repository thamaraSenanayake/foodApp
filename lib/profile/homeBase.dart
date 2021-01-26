import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/message/Message.dart';
import 'package:food_app/profile/addPost.dart';
import 'package:food_app/profile/profile.dart';
import 'package:food_app/profile/search.dart';
import 'package:food_app/profile/userCategorySelect.dart';

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
            
            // Container(
            //   height:_height,
            //   width:_width,
            //   child: Image.asset(
            //     AppData.BACKGROUNDPATH,
            //     fit:BoxFit.cover
            //   ),
            // ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _width,
                height: 50,
                color: AppData.secondaryColor,
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _width,
                height: 40,
                color: AppData.secondaryColor,
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
                        color: AppData.secondaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _profilePage = ProfilePage.Search;
                              });
                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                  color: AppData.primaryColor,
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
                                  color: AppData.primaryColor,
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
                      _profilePage == ProfilePage.Add ? AddPost(user: widget.user):
                      _profilePage == ProfilePage.Message ? MessageView(user: widget.user):
                      _profilePage == ProfilePage.Category ? UserCategorySelect(user: widget.user):
                      _profilePage == ProfilePage.Search ? SearchScreen(user: widget.user):
                      Container()
                    ),
                    Container(
                      height: 50,
                      color: AppData.secondaryColor,
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
                              color: AppData.secondaryColor,
                              child: Icon(
                                Icons.home,
                                color: AppData.primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _profilePage = ProfilePage.Category;
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              color: AppData.secondaryColor,
                              child: Icon(
                                Icons.menu,
                                color: AppData.primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _profilePage = ProfilePage.Message;
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              color: AppData.secondaryColor,
                              child: Icon(
                                Icons.message,
                                color: AppData.primaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              setState(() {
                                _profilePage = ProfilePage.Add;
                              });
                            },
                            child: Container(
                              height: 80,
                              width: 80,
                              color: AppData.secondaryColor,
                              child: Icon(
                                Icons.add,
                                color: AppData.primaryColor,
                              ),
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