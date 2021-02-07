import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/login/loginBase.dart';
import 'package:food_app/login/splash.dart';
import 'package:food_app/model/message.dart';
import 'package:food_app/model/messageHead.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/review.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/message/Message.dart';
import 'package:food_app/profile/addPost/addPost.dart';
import 'package:food_app/profile/profile/profile.dart';
import 'package:food_app/profile/search.dart';
import 'package:food_app/profile/categorySelect/userCategorySelect.dart';

import '../const.dart';
import 'home.dart';

class HomeBase extends StatefulWidget {
  final User user;
  HomeBase({Key key, @required this.user}) : super(key: key);

  @override
  _HomeBaseState createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> with TickerProviderStateMixin implements HomeBaseListener  {
  double _height;
  double _width;
  ProfilePage _profilePage = ProfilePage.Home;
  bool _bottomBarVisibility = true;
  TabController _tabController;
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _getLiveUpdates();
    KeyboardVisibility.onChange.listen((bool visible) {
      if(mounted) {
        setState(() {
          _bottomBarVisibility =! visible;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    // totalTimerService.dispose();
    super.dispose();
  }

  _getLiveUpdates(){
    CollectionReference reference = Database().users;
    reference
    .document(widget.user.telNumber) 
    .snapshots().listen((querySnapshot) {
      List<Review> _reviewList = [];
      int _newCount = 0;
      print("live update");
      print(querySnapshot["reviewList"]);
      
      for (var itemReviewList in querySnapshot["reviewList"]) {
        Timestamp dateTime = itemReviewList['dateTime'];
        Timestamp replyTime = itemReviewList['replyTime'];
        _reviewList.add(
          Review()
          ..id = itemReviewList['id']
          ..review = itemReviewList['review']
          ..starCount = itemReviewList['starCount']
          ..userTelNumber = itemReviewList['userTelNumber']
          ..userName = itemReviewList['userName']
          ..dateTime = DateTime.fromMillisecondsSinceEpoch(dateTime.millisecondsSinceEpoch) 
          ..reply = itemReviewList['reply']
          ..read = itemReviewList['read']
          ..replyTime = replyTime == null? null: DateTime.fromMillisecondsSinceEpoch(replyTime.millisecondsSinceEpoch) 
        );
      }

      for (var item in _reviewList) {
        if(!item.read){
          ++_newCount;
        }
      }

      if(_newCount > 0){
        setState(() {
          widget.user.reviewList = _reviewList;
          AppData.reviewCount = _newCount;
        });
      }else{
        setState(() {
          AppData.reviewCount = 0;
        });
      }


    });

    List<MessageHeader> messageHeader = [];
    CollectionReference msgList = Database().msgReference;
    msgList
    .where('user1',isEqualTo: widget.user.telNumber)
    .where('user2',isEqualTo: widget.user.telNumber)
    .snapshots().listen((querySnapshot) {
      messageHeader = Database().setMessageHeader(querySnapshot);
      for (var item in messageHeader) {
        for (SingleMessage msgList in item.msgList) {
          
        }
      }
    });


  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    });
    return DefaultTabController(
      length: 4,
      child: Scaffold(
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

             _bottomBarVisibility? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: _width,
                  height: 40,
                  color: AppData.secondaryColor,
                ),
              ):Container(),

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
                                    color:_profilePage == ProfilePage.Search? AppData.thirdColor: AppData.primaryColor,
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
                                child: Row(
                                  children: [
                                    Center(
                                      child: Icon(
                                        Icons.person,
                                        color:_profilePage == ProfilePage.Profile? AppData.thirdColor: AppData.primaryColor,
                                      ),
                                    ),
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
                                    ):Container()
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child:_profilePage == ProfilePage.Search? 
                          SearchScreen(user: widget.user):
                        _profilePage == ProfilePage.Profile ?
                         Profile(user: widget.user, listener: this,)
                        :TabBarView(
                          // physics:ScrollPhysics(parent: ) ,
                          controller:_tabController,
                          children: [
                            HomePage(user: widget.user,listener: this),
                            UserCategorySelect(user: widget.user,listener: this),
                            MessageView(user: widget.user,listener: this),
                            AddPost(user: widget.user,post: Post(),listener: this,)
                          ],
                        )
                        // child: _profilePage == ProfilePage.Home ? HomePage(user: widget.user,):
                        // _profilePage == ProfilePage.Profile ? Profile(user: widget.user, listener: this,):
                        // _profilePage == ProfilePage.Add ? AddPost(user: widget.user,post: Post(),listener: this,):
                        // _profilePage == ProfilePage.Message ? MessageView(user: widget.user):
                        // _profilePage == ProfilePage.Category ? UserCategorySelect(user: widget.user):
                        // _profilePage == ProfilePage.Search ? SearchScreen(user: widget.user):
                        // Container()
                      ),
                      _bottomBarVisibility?Container(
                        height: 50,
                        color: AppData.secondaryColor,
                        child: TabBar(
                          indicatorColor:Colors.transparent,
                          onTap: (val){
                            if (val == 0) {
                              _tabController.animateTo(0);
                              
                              setState(() {
                                _profilePage = ProfilePage.Home;
                              });
                            } else if (val == 1) {
                              _tabController.animateTo(1);
                              setState(() {
                                _profilePage = ProfilePage.Category;
                              });
                            }
                            else if (val == 2) {
                              _tabController.animateTo(2);
                              setState(() {
                                _profilePage = ProfilePage.Message;
                              });
                            }
                            else if (val == 3) {
                              _tabController.animateTo(3);
                              setState(() {
                                _profilePage = ProfilePage.Add;
                              });
                            }
                          },
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          tabs: [
                            Tab(
                              // onTap: (){
                              //   setState(() {
                              //     _profilePage = ProfilePage.Home;
                              //   });
                              // },
                              child: Container(
                                height: 80,
                                width: 80,
                                color: AppData.secondaryColor,
                                child: Icon(
                                  Icons.home,
                                  color:_profilePage == ProfilePage.Home? AppData.thirdColor: AppData.primaryColor,
                                ),
                              ),
                            ),
                            Tab(
                              // onTap: (){
                              //   setState(() {
                              //     _profilePage = ProfilePage.Category;
                              //   });
                              // },
                              child: Container(
                                height: 80,
                                width: 80,
                                color: AppData.secondaryColor,
                                child: Icon(
                                  Icons.menu,
                                  color:_profilePage == ProfilePage.Category? AppData.thirdColor: AppData.primaryColor,
                                ),
                              ),
                            ),
                            Tab(
                              // onTap: (){
                              //   setState(() {
                              //     _profilePage = ProfilePage.Message;
                              //   });
                              // },
                              child: Container(
                                height: 80,
                                width: 80,
                                color: AppData.secondaryColor,
                                child: Icon(
                                  Icons.message,
                                  color:_profilePage == ProfilePage.Message? AppData.thirdColor: AppData.primaryColor,
                                ),
                              ),
                            ),
                            Tab(
                              // onTap: (){
                              //   setState(() {
                              //     _profilePage = ProfilePage.Add;
                              //   });
                              // },
                              child: Container(
                                height: 80,
                                width: 80,
                                color: AppData.secondaryColor,
                                child: Icon(
                                  Icons.add,
                                  color:_profilePage == ProfilePage.Add? AppData.thirdColor: AppData.primaryColor,
                                ),
                              ),
                            )
                          ],
                        ),
                      ):Container()
                    ],
                  ),
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  logout() {
    final storage = new FlutterSecureStorage();
    storage.deleteAll();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginBase()
      )
    );
  }

  @override
  moveToPage(ProfilePage page) {
    setState(() {
      _profilePage = page;
    });
    _tabController.animateTo(0);
  }

  @override
  setPage(ProfilePage page) {
    setState(() {
      _profilePage = page;
    });
  }
}

abstract class HomeBaseListener{
  moveToPage(ProfilePage page);
  setPage(ProfilePage page);
  logout();
}