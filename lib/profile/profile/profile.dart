import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/profile/myFacourite.dart';
import 'package:food_app/profile/profile/myUploads.dart';
import 'package:food_app/profile/profile/notification.dart';
import 'package:food_app/profile/profile/personalInformation.dart';
import 'package:food_app/profile/profile/settings.dart';
import 'package:food_app/profile/profile/viewReview.dart';

import '../homeBase.dart';

class Profile extends StatefulWidget {
  final User user;
  final HomeBaseListener listener;
  Profile({Key key,@required this.user,@required this.listener}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Container(
                width: _width-20,
                height: 200,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color:AppData.primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25)),
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      blurRadius: 12.0,
                      spreadRadius: 3.0,
                      offset: Offset(
                        1.0,
                        1.0,
                      ),
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: _width-40,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                         widget.user.profilePicUrl.isNotEmpty? Padding(
                           padding: const EdgeInsets.only(left:10.0),
                           child: Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  100
                                ),
                                image: DecorationImage(
                                  image:widget.user.profilePicUrl.isNotEmpty? NetworkImage(widget.user.profilePicUrl):null,
                                  fit: BoxFit.cover,
                                )
                              ),
                            ),
                         ):Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                100
                              ),
                              color: AppData.secondaryColor
                            ),
                            child:Center(
                              child: Text(
                                widget.user.name[0],
                                style: TextStyle(
                                  color: AppData.primaryColor,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 35
                                ),
                              ),
                            ),
                          ),
                          Text(
                            widget.user.name,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: AppData.secondaryColor
                            ),
                          ),
                          GestureDetector(
                            onTap: () async{
                              await Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) => PersonalInformation(
                                    user: widget.user,
                                  ),
                                  opaque: false
                                ),
                              );
                              setState(() {
                                
                              });
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              size: 35,
                              color: AppData.secondaryColor
                            ),
                          )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => MyUploads(
                              user: widget.user,
                            ),
                            opaque: false
                          ),
                        );
                      },
                      child: Container(
                        width: _width-40,
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            // Container(
                            //   height: 50,
                            //   width: 120,
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(10.0),
                            //     border: Border.all(
                            //       color: Colors.blue,
                            //       width: 3
                            //     )
                            //   ),
                            //   child: Center(
                            //     child: Text(
                            //       "My Upload",
                            //       style: TextStyle(
                            //         fontSize: 15,
                            //         fontWeight: FontWeight.w800
                            //       ),
                            //     ),
                            //   ),
                            // ),

                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppData.secondaryColor,
                                  width: 3
                                )
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Following "+widget.user.flowing.length.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppData.secondaryColor
                                  ),
                                ),
                              ),
                            ),

                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppData.secondaryColor,
                                  width: 3
                                )
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Text(
                                  "Followers "+widget.user.flowers.length.toString(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppData.secondaryColor
                                  ),
                                ),
                              ),
                            ),
                            
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom:10.0),
              child: Container(
                
                child: Column(
                  children: [
                    Container(
                      // color: Colors.white,
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, _, __) => MyUploads(
                                user: widget.user,
                              ),
                              opaque: false
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.file_upload,
                          color: AppData.secondaryColor,
                        ),
                        title: Text(
                          "My Uploads",
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 20
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: AppData.secondaryColor,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, _, __) => ViewReview(
                                user: widget.user,
                              ),
                              opaque: false
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.feedback,

                          color: AppData.secondaryColor,
                        ),
                        title: Text(
                          "User Feedback",
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 20
                          ),
                        ),
                        trailing: Container(
                          width: 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppData.reviewCount != 0? Container(
                                decoration: BoxDecoration(
                                  color: AppData.thirdColor,
                                  shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppData.reviewCount.toString(),
                                    style: TextStyle(
                                      color: AppData.secondaryColor,
                                      fontWeight: FontWeight.w500
                                    ),

                                  ),
                                ),
                              ):Container(),
                              Icon(
                                Icons.arrow_forward,
                                color: AppData.secondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, _, __) => NotificationScreen(
                                user: widget.user,
                              ),
                              opaque: false
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.notifications,

                          color: AppData.secondaryColor,
                        ),
                        title: Text(
                          "Notifications",
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 20,
                          ),
                        ),
                        trailing:Container(
                          width: 65,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AppData.clapCount != 0? Container(
                                decoration: BoxDecoration(
                                  color: AppData.thirdColor,
                                  shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    AppData.clapCount.toString(),
                                    style: TextStyle(
                                      color: AppData.secondaryColor,
                                      fontWeight: FontWeight.w500
                                    ),

                                  ),
                                ),
                              ):Container(),
                              Icon(
                                Icons.arrow_forward,
                                color: AppData.secondaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, _, __) => FavoriteScreen(
                                user: widget.user,
                              ),
                              opaque: false
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.star,

                          color: AppData.secondaryColor,
                        ),
                        title: Text(
                          "My favorite",
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 20
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: AppData.secondaryColor,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      // color: Colors.white,
                      child: ListTile(
                        onTap: (){
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, _, __) => SettingsScreen(
                                user: widget.user,
                                logout: (){
                                  widget.listener.logout();
                                },
                              ),
                              opaque: false
                            ),
                          );
                        },
                        leading: Icon(
                          Icons.settings,
                          color: AppData.secondaryColor,

                        ),
                        title: Text(
                          "Settings",
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 20
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: AppData.secondaryColor,
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      // color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.support,
                          color: AppData.secondaryColor,
                        ),
                        title: Text(
                          "Support",
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 20
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward,
                          color: AppData.secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}