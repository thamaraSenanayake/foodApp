import 'package:flutter/material.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';

import '../const.dart';

class UserCategorySelect extends StatefulWidget {
  final User user;
  UserCategorySelect({Key key,@required this.user}) : super(key: key);

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
                    widget.user.category = _category;
                    Database().updateUser(widget.user);
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
                    color:_category == UserCategory.FoodIndustry? Colors.black:Colors.transparent,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Agriculture;
                    });
                    widget.user.category = _category;
                    Database().updateUser(widget.user);
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
                    color:_category == UserCategory.Agriculture? Colors.black:Colors.transparent,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Animal;
                    });
                    widget.user.category = _category;
                    Database().updateUser(widget.user);
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
                    color:_category == UserCategory.Animal? Colors.black:Colors.transparent,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Business;
                    });
                    widget.user.category = _category;
                    Database().updateUser(widget.user);
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
                    color:_category == UserCategory.Business? Colors.black:Colors.transparent,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Service;
                    });
                    widget.user.category = _category;
                    Database().updateUser(widget.user);
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
                    color:_category == UserCategory.Service? Colors.black:Colors.transparent,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Education;
                    });
                    widget.user.category = _category;
                    Database().updateUser(widget.user);
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
                    color:_category == UserCategory.Education? Colors.black:Colors.transparent,
                  ),
                ),
                ListTile(
                  onTap:(){
                    setState(() {
                      _category = UserCategory.Others;
                    });
                    widget.user.category = _category;
                    Database().updateUser(widget.user);
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
                    color:_category == UserCategory.Others? Colors.black:Colors.transparent,
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