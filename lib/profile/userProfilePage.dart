import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/viewPost.dart';
import 'package:food_app/profile/addReview.dart';

import '../const.dart';

class UserProfilePage extends StatefulWidget {
  final User user;
  final String otherUserId;
  UserProfilePage({Key key,@required this.user,@required this.otherUserId}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> implements ViewPostListener {
  double _width =0.0;
  double _height = 0.0;
  bool _viewContactDetails = false;
  int _startCount = 0;
  User otherUser;
  bool _loading = true;
  List<Post> _post = [];
  List<Widget> _widgetList = [];

  @override
  void initState() { 
    super.initState();
    _getUserData();
  }

  _getUserData() async {
    List<Widget> widgetList = [];
    otherUser = await Database().getUser(widget.otherUserId);
    _post = await Database().getMyPost(otherUser);
    for (var item in _post) {
      widgetList.add(
        ViewPost(post: item, user: widget.user, listener: this,myPost: false,)
      );
    }
    setState(() {
      _widgetList = widgetList;
       _loading = false;
    });
    for (var item in otherUser.reviewList) {
      _startCount += item.starCount;
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width =MediaQuery.of(context).size.width;
      _height =MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body:_loading
      ? Container(
        color: Color.fromRGBO(128, 128, 128, 0.3),
        child: SpinKitSquareCircle(
          color: AppData.secondaryColor,
          size: 50.0,
        ),
      ): Container(
        child: Stack(
          children: [

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _width,
                height: 50,
                color: AppData.secondaryColor,
              ),
            ),
            
            Container(
              height: _height,
              width: _width,
              child: SafeArea(
                child: Column(
                  children: [

                    //header
                    Container(
                      width: _width,
                      height: 150,
                      color: AppData.secondaryColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Column(
                          children: [
                            Container(
                              height: 110,
                              child: Row(
                                children:[
                                  otherUser.profilePicUrl.isNotEmpty? Container(
                                    height:100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                        image: NetworkImage(otherUser.profilePicUrl),
                                        fit: BoxFit.cover,
                                      )
                                    )
                                  ):Container(
                                    height:100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: AppData.primaryColor,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Center(
                                      child: Text(
                                        otherUser.name[0],
                                        style: TextStyle(
                                          fontSize: 40,
                                          color: AppData.secondaryColor,
                                          fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    ),

                                  ),
                                  Container(
                                    width: _width-160,
                                    height: 100,
                                    child: Padding(
                                      padding:EdgeInsets.only(top:6.0,left: 5),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            otherUser.name,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: AppData.primaryColor
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            width: _width-140,
                                            child: Row(
                                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.star,
                                                  color: AppData.thirdColor,
                                                ),
                                                otherUser.reviewList.length != 0 ?Padding(
                                                  padding: const EdgeInsets.symmetric( horizontal: 8),
                                                  child: Text(
                                                    "${_startCount/otherUser.reviewList.length}(${otherUser.reviewList.length})",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800,
                                                      color: AppData.primaryColor
                                                    ),
                                                  ),
                                                ):Text(
                                                  "No ",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: AppData.primaryColor
                                                  ),
                                                ),
                                                Text(
                                                  "Reviews",
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: AppData.primaryColor
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: _width-140,
                                            height: 30,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  color: AppData.secondaryColor,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child: Text(
                                                      "Flowing : ${otherUser.flowing.length}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppData.primaryColor,
                                                      ),
                                                      
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  color: AppData.secondaryColor ,
                                                  child: Padding(
                                                    padding: const EdgeInsets.all(3.0),
                                                    child: Text(
                                                      "Followers : ${otherUser.flowers.length}",
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppData.primaryColor,
                                                      ),
                                                      
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   height: 20,
                                          // ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: _width,
                              height: 30,
                              // color: Colors.blue,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (widget.user.flowing.contains(otherUser.telNumber)) {
                                        widget.user.flowing.remove(otherUser.telNumber);
                                        Database().unFollow(otherUser, widget.user);
                                      } else {
                                        Database().follow(otherUser, widget.user);
                                        widget.user.flowing.add(otherUser.telNumber);
                                      }
                                      setState(() {
                                        
                                      });
                                    },
                                    child: Container(
                                      height: 30,
                                      width: (_width-90)/2,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                      child:Center(
                                        child: Text(
                                          widget.user.flowing.contains(otherUser.telNumber)?"Unfollow":"Follow",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.of(context).push(
                                        PageRouteBuilder(
                                          pageBuilder: (context, _, __) => AddReview(
                                            user: widget.user,
                                            otherUser: otherUser,
                                          ),
                                          opaque: false
                                        ),
                                      );
                                    },
                                    child: Container(
                                      height: 30,
                                      width: (_width-90)/2,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
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
                                      child:Center(
                                        child: Text(
                                          "Review",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            )
                          ],
                        ),
                      ),
                    ),
                    
                    Expanded(
                      child: Container(
                        // height: _height - 228,
                        width: _width,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              //details container
                              Padding(
                                padding: const EdgeInsets.only(top:10.0),
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      _viewContactDetails = !_viewContactDetails;
                                    });
                                  },
                                  child: Container(
                                    height: 30,
                                    width: _width,
                                    padding: EdgeInsets.symmetric(horizontal:10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Contact Details",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800,
                                            color: AppData.secondaryColor,
                                          ),
                                        ),
                                        Icon(
                                          !_viewContactDetails? Icons.keyboard_arrow_down:Icons.keyboard_arrow_up
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              _viewContactDetails?Container(
                                width: _width,
                                // transform: ,
                                padding: EdgeInsets.symmetric(horizontal:10,vertical:5 ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children:[
                                            TextSpan(
                                              text:"Tel: ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: AppData.secondaryColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text:otherUser.telNumber,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: AppData.secondaryColor,
                                              ),
                                            )
                                          ]
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children:[
                                            TextSpan(
                                              text:"Email: ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: AppData.secondaryColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text:otherUser.email,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: AppData.secondaryColor,
                                              ),
                                            )
                                          ]
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children:[
                                            TextSpan(
                                              text:"Address: ",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: AppData.secondaryColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text:otherUser.address,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: AppData.secondaryColor,
                                              ),
                                            )
                                          ]
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom:4.0),
                                      child: RichText(
                                        text: TextSpan(
                                          children:[
                                            TextSpan(
                                              text:"Description: \n",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: AppData.secondaryColor,
                                              ),
                                            ),
                                            TextSpan(
                                              text:otherUser.description,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                                color: AppData.secondaryColor,
                                              ),
                                            )
                                          ]
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ):Container(),
                              Container(
                                height: 30,
                                width: _width,
                                padding: EdgeInsets.symmetric(horizontal:10),
                                child: Text(
                                  "Posts",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                    color: AppData.secondaryColor,
                                  ),
                                ),
                              ),
                              Column(
                                children: _widgetList,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    



                  ],
                ),
              )
              ,
            ),

            Align(
              alignment: Alignment.topCenter,
              child: Container(
                // height: 40,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      // color: Colors.red,
                      height: 40,
                      // width: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left:10.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Icon(
                            Icons.arrow_back,
                            color: AppData.primaryColor,
                            size: 35,
                          ),
                        ),
                      ),
                    ),
                  )
                )
              ),
            )

          ],
        ),
      ),
    );
  }

  @override
  clap(String postId) {
    // TODO: implement clap
  }

  @override
  goToLocation(location) {
    // TODO: implement goToLocation
  }

  @override
  moreClick(String postId) {
    // TODO: implement moreClick
  }

  @override
  moveToProfile(String userTelNumber) {
    // TODO: implement moveToProfile
  }

  @override
  sendMessage(User otherUser) {
    // TODO: implement sendMessage
  }

  @override
  takeCall(String userTelNumber) {
    // TODO: implement takeCall
  }

  @override
  canEdit(Post postId) {
    // TODO: implement moreClick
  }

  @override
  addToFavorite(String postId) {
    // TODO: implement moreClick
  }
}