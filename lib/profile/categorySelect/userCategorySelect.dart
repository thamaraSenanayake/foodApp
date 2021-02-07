import 'package:flutter/material.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/categorySelect/postsToCategory.dart';

import '../../const.dart';
import '../homeBase.dart';

class UserCategorySelect extends StatefulWidget {
  final User user;
  final HomeBaseListener listener;
  UserCategorySelect({Key key,@required this.user,@required this.listener}) : super(key: key);

  @override
  _UserCategorySelectState createState() => _UserCategorySelectState();
}

class _UserCategorySelectState extends State<UserCategorySelect> {
  double _width = 0.0;
  double _height = 0.0;
  UserCategory _category;


  @override
  void initState() { 
    super.initState();
    _category = widget.user.category;
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      widget.listener.setPage(ProfilePage.Category);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return SafeArea(
      child: Container(
        width: _width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Text(
                "Select Category",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.FoodIndustry;
                    });
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: _category,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Food industry",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color:_category == UserCategory.FoodIndustry? AppData.secondaryColor:Colors.transparent,
                    size: 35,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Agriculture;
                    });
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: _category,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Agriculture",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color:_category == UserCategory.Agriculture? AppData.secondaryColor:Colors.transparent,
                    size: 35,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Animal;
                    });
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: _category,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Animal",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color:_category == UserCategory.Animal? AppData.secondaryColor:Colors.transparent,
                    size: 35,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Business;
                    });
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: _category,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Business",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color:_category == UserCategory.Business? AppData.secondaryColor:Colors.transparent,
                    size: 35,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Service;
                    });
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: _category,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Service",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color:_category == UserCategory.Service? AppData.secondaryColor:Colors.transparent,
                    size: 35,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Education;
                    });
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: _category,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Education",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color:_category == UserCategory.Education? AppData.secondaryColor:Colors.transparent,
                    size: 35,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Others;
                    });
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: _category,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Others",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color:_category == UserCategory.Others? AppData.secondaryColor:Colors.transparent,
                    size: 35,
                  ),
                ),
              ],
            ),
            Container()
          ],
        ),             
      )
    );
  }
}