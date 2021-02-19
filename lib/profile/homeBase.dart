import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/login/loginBase.dart';
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
import 'message/messageView.dart';

class HomeBase extends StatefulWidget {
  final User user;
  HomeBase({Key key, @required this.user}) : super(key: key);

  @override
  _HomeBaseState createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> with TickerProviderStateMixin implements HomeBaseListener  {
  double _height;
  double _width;
  double _bottomPosition = 100.0;
  ProfilePage _profilePage = ProfilePage.Home;
  bool _bottomBarVisibility = true;
  TabController _tabController;
  bool _displayUploadProgress = false;
  double _progressBarWidth = 0.0;

  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _getLiveUpdates();
    KeyboardVisibility.onChange.listen((bool visible) {
      if(mounted){
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
      int clapCount = querySnapshot["clapCount"];
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
        if(mounted){
          setState(() {
            widget.user.reviewList = _reviewList;
            AppData.reviewCount = _newCount;
          });
          
        }
      }else{
        if(mounted){
          setState(() {
            AppData.reviewCount = 0;
          });
        }
      }

      if(clapCount != null){
        AppData.clapCount = clapCount;
      }


    });

    List<MessageHeader> messageHeader = [];
    CollectionReference msgList = Database().msgReference;
    msgList
    .where('user1',isEqualTo: widget.user.telNumber)
    .snapshots().listen((querySnapshot) {
      messageHeader = Database().setMessageHeader(querySnapshot,widget.user);
      if(messageHeader != null && _profilePage != ProfilePage.Message){
        int msgCount = 0;
        for (var item in messageHeader) {
          msgCount += item.unreadMsgCount;
        }
        if(mounted){
          setState(() {
            AppData.msgCount += msgCount;
          });
        }
      }
    });

    msgList
    .where('user2',isEqualTo: widget.user.telNumber)
    .snapshots().listen((querySnapshot) {
      messageHeader = Database().setMessageHeader(querySnapshot,widget.user);
      if(messageHeader != null && _profilePage != ProfilePage.Message){
        int msgCount = 0;
        for (var item in messageHeader) {
          msgCount += item.unreadMsgCount;
        }
        if(mounted){
          setState(() {
            AppData.msgCount += msgCount;
          });
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
      child: WillPopScope(
        onWillPop:_onBackPressed,
        child: Scaffold(
          body: Container(
            height:_height,
            width:_width,
            child: Stack(
              children: [
                
                Container(
                  height:_height,
                  width:_width,
                  color: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,

                  // child: Image.asset(
                  //   AppData.BACKGROUNDPATH,
                  //   fit:BoxFit.cover
                  // ),
                ),

                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: _width,
                    height: 50,
                    color: AppData.primaryColor,
                  ),
                ),

               _bottomBarVisibility? Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: _width,
                    height: 40,
                    color: AppData.primaryColor,
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
                            color: AppData.primaryColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: (){
                                  if(mounted){
                                    setState(() {
                                      _profilePage = ProfilePage.Search;
                                    });
                                  } 
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  child: Center(
                                    child: Icon(
                                      Icons.search,
                                      color:_profilePage == ProfilePage.Search? AppData.thirdColor: AppData.secondaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width:10),
                              GestureDetector(
                                onTap: (){
                                  if(mounted){
                                    setState(() {
                                      _profilePage = ProfilePage.Profile;
                                    });
                                  } 
                                },
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  child: Row(
                                    children: [
                                      Center(
                                        child: Icon(
                                          Icons.person,
                                          color:_profilePage == ProfilePage.Profile? AppData.thirdColor: AppData.secondaryColor,
                                        ),
                                      ),
                                      AppData.reviewCount + AppData.clapCount != 0? Container(
                                        decoration: BoxDecoration(
                                          color: AppData.thirdColor,
                                          shape: BoxShape.circle
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            (AppData.clapCount + AppData.reviewCount).toString(),
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
                            physics: NeverScrollableScrollPhysics(),
                            controller:_tabController,
                            children: [
                              HomePage(user: widget.user,listener: this),
                              UserCategorySelect(user: widget.user,listener: this),
                              MessageView(user: widget.user,listener: this),
                              AddPost(user: widget.user,post: Post(),listener: this,)
                            ],
                          )
                        ),
                        _bottomBarVisibility?Container(
                          height: 50,
                          color: AppData.primaryColor,
                          child: TabBar(
                            indicatorColor:Colors.transparent,
                            onTap: (val){
                              if (val == 0) {
                                _tabController.animateTo(0);
                                
                                if(mounted){
                                  setState(() {
                                    _profilePage = ProfilePage.Home;
                                  });
                                } 
                              } else if (val == 1) {
                                _tabController.animateTo(1);
                                if(mounted){
                                  setState(() {
                                    _profilePage = ProfilePage.Category;
                                  });
                                } 
                              }
                              else if (val == 2) {
                                _tabController.animateTo(2);
                                if(mounted){
                                  setState(() {
                                    AppData.msgCount = 0;
                                    _profilePage = ProfilePage.Message;
                                  });
                                } 
                              }
                              else if (val == 3) {
                                _tabController.animateTo(3);
                                if(mounted){
                                  setState(() {
                                    _profilePage = ProfilePage.Add;
                                  });
                                } 
                              }
                            },
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            tabs: [
                              Tab(
                                // onTap: (){
                                //   if(mounted){} setState(() {
                                //     _profilePage = ProfilePage.Home;
                                //   });
                                // },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  color: AppData.primaryColor,
                                  child: Icon(
                                    Icons.home,
                                    color:_profilePage == ProfilePage.Home? AppData.thirdColor:AppData.secondaryColor,
                                  ),
                                ),
                              ),
                              Tab(
                                // onTap: (){
                                //   if(mounted){} setState(() {
                                //     _profilePage = ProfilePage.Category;
                                //   });
                                // },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  color: AppData.primaryColor,
                                  child: Icon(
                                    Icons.menu,
                                    color:_profilePage == ProfilePage.Category? AppData.thirdColor:AppData.secondaryColor,
                                  ),
                                ),
                              ),
                              Tab(
                                // onTap: (){
                                //   if(mounted){} setState(() {
                                //     _profilePage = ProfilePage.Message;
                                //   });
                                // },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  color: AppData.primaryColor,
                                  // color: Colors.blue,
                                  child: Stack(
                                    children:[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Icon(
                                          Icons.message,
                                          color:_profilePage == ProfilePage.Message? AppData.thirdColor:AppData.secondaryColor,
                                        ),
                                      ),

                                      AppData.msgCount != 0? Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: AppData.thirdColor,
                                            shape: BoxShape.circle
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              AppData.msgCount.toString(),
                                              style: TextStyle(
                                                color: AppData.secondaryColor,
                                                fontWeight: FontWeight.w500
                                              ),

                                            ),
                                          ),
                                        ),
                                      ):Container()

                                    ],
                                  ),
                                ),
                              ),
                              Tab(
                                // onTap: (){
                                //   if(mounted){} setState(() {
                                //     _profilePage = ProfilePage.Add;
                                //   });
                                // },
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  color: AppData.primaryColor,
                                  child: Icon(
                                    Icons.add,
                                    color:_profilePage == ProfilePage.Add? AppData.thirdColor:AppData.secondaryColor,
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

                _displayUploadProgress ?Positioned(
                  top:_bottomPosition,
                  left: 10,
                  child: Draggable(
                    onDragEnd: (details){
                      print(details.offset.dy);
                      if(mounted){
                        setState(() {
                          _bottomPosition = details.offset.dy;
                        });
                      } 
                    },
                    childWhenDragging: Container(
                    ),
                    feedback:Container(
                      width:_width-20,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppData.primaryColor,
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width:_width-80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Uploading",
                                  style: TextStyle(
                                    color: AppData.secondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Container(
                                  width:_width-80,
                                  height: 5,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:_width-80,
                                        height: 5,
                                        color: Colors.grey,
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        width: _progressBarWidth,
                                        height: 5,
                                        color: AppData.thirdColor,
                                      )
                                    ],
                                  ),
                                ),
                                Container()

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: GestureDetector(
                              onTap: (){
                                if(mounted){
                                  setState(() {
                                    _displayUploadProgress = false;
                                  });
                                } 
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppData.secondaryColor,
                                  shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.close,
                                    color:AppData.primaryColor
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    child: Container(
                      width:_width-20,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppData.primaryColor,
                        // color: Colors.blue,
                        borderRadius: BorderRadius.circular(3),
                        boxShadow: [
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width:_width-80,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Uploading",
                                  style: TextStyle(
                                    color: AppData.secondaryColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  ),
                                ),
                                Container(
                                  width:_width-80,
                                  height: 5,
                                  child: Stack(
                                    children: [
                                      Container(
                                        width:_width-80,
                                        height: 5,
                                        color: Colors.grey,
                                      ),
                                      AnimatedContainer(
                                        duration: Duration(milliseconds: 400),
                                        width: _progressBarWidth,
                                        height: 5,
                                        color: AppData.thirdColor,
                                      )
                                    ],
                                  ),
                                ),
                                Container()

                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: GestureDetector(
                              onTap: (){
                                if(mounted){
                                  setState(() {
                                    _displayUploadProgress = false;
                                  });
                                } 
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppData.secondaryColor,
                                  shape: BoxShape.circle
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Icon(
                                    Icons.close,
                                    color:AppData.primaryColor
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ):Container(),
              ],
            ),
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
    if(mounted){
      setState(() {
        _profilePage = page;
      });
    } 
    _tabController.animateTo(0);
  }

  @override
  moveToMsg(User user,User otherUser) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => MessageScreen(
          user: widget.user,
          otherUser:otherUser
        ),
        opaque: false
      ),
    );
  }

  @override
  setPage(ProfilePage page) {
    print(page);
    if(mounted){
      setState(() {
        _profilePage = page;
      });
    } 
  }

  @override
  updateState() {
    if(mounted){
      setState(() {
      });
    } 
  }

  @override
  progressBarStart(){
    if(mounted){
      setState(() {
        _displayUploadProgress = true;
        _progressBarWidth = 60;
      });
    } 
  }

  @override
  progressBarUpdate(double width)  {
    if(mounted){
      setState(() {
        _progressBarWidth += width;
      });
    } 
  }

  @override
  progressBarHide() async {
    await new Future.delayed(const Duration(microseconds : 700));
    if(mounted){
      setState(() {
        _displayUploadProgress = false;
        _progressBarWidth = 0;
      });
    } 
  }
  Future<bool> _onBackPressed() {
    
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?'),
          content: new Text('Do you want to exit an App'),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO"),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(true),
              child: Text("YES"),
            ),
          ],
        ),
      ) ??
          false;
        
  }
}

abstract class HomeBaseListener{
  moveToPage(ProfilePage page);
  setPage(ProfilePage page);
  logout();
  moveToMsg(User user,User otherUser);
  updateState();
  progressBarStart();
  progressBarUpdate(double width);
  progressBarHide();
}