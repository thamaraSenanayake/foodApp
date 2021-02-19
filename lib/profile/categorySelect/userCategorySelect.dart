import 'package:flutter/material.dart';
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


  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      // widget.listener.setPage(ProfilePage.Category);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
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
                  color: AppData.secondaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w700
                ),
              ),
            ),
            Column(
              children: [
                ListTile(
                  onTap:(){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: UserCategory.FoodIndustry,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Food industry",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color:AppData.secondaryColor,
                    size: 25,
                  ),
                ),
                ListTile(
                  onTap:(){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: UserCategory.Agriculture,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Agriculture",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color:AppData.secondaryColor,
                    size: 25,
                  ),
                ),
                ListTile(
                  onTap:(){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: UserCategory.Animal,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Animal",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color:AppData.secondaryColor,
                    size: 25,
                  ),
                ),
                ListTile(
                  onTap:(){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: UserCategory.Business,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Business",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color:AppData.secondaryColor,
                    size: 25,
                  ),
                ),
                ListTile(
                  onTap:(){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: UserCategory.Service,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Service",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color:AppData.secondaryColor,
                    size: 25,
                  ),
                ),
                ListTile(
                  onTap:(){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: UserCategory.Education,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Education",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color:AppData.secondaryColor,
                    size: 25,
                  ),
                ),
                ListTile(
                  onTap:(){
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, _, __) => PostsToCategory(
                          user: widget.user,
                          category: UserCategory.Others,
                        ),
                        opaque: false
                      ),
                    );
                  },
                  title: Text(
                    "Others",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 20
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color:AppData.secondaryColor,
                    size: 25,
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