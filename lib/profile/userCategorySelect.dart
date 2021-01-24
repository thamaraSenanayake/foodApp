import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';

class UserCategorySelect extends StatefulWidget {
  final User user;
  UserCategorySelect({Key key,@required this.user}) : super(key: key);

  @override
  _UserCategorySelectState createState() => _UserCategorySelectState();
}

class _UserCategorySelectState extends State<UserCategorySelect> {
  double _width = 0.0;
  double _height = 0.0;
  
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
                "Category",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  title: Text(
                    "Food industry",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Agriculture",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Animal",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Business",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Service",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Education",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color: Colors.black,
                  ),
                ),
                ListTile(
                  title: Text(
                    "Others",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.check,
                    color: Colors.black,
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