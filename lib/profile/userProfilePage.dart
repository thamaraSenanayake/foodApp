import 'package:flutter/material.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/viewPost.dart';
import 'package:food_app/profile/addReview.dart';

import '../const.dart';

class UserProfilePage extends StatefulWidget {
  final User user;
  UserProfilePage({Key key,@required this.user}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> implements ViewPostListener {
  double _width =0.0;
  double _height = 0.0;
  bool _viewContactDetails = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width =MediaQuery.of(context).size.width;
      _height =MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body: Container(
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
                                  Padding(
                                    padding: const EdgeInsets.only(top:0.0),
                                    child: Container(
                                      height:100,
                                      width: 100,
                                      decoration: BoxDecoration(
                                        color: Colors.black,
                                        borderRadius: BorderRadius.circular(100),
                                        image: DecorationImage(
                                          image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeabWkXTrS3TpRsbQ3ugejErdv4lfff8FgPw&usqp=CAU'),
                                          fit: BoxFit.cover,
                                        )
                                      )
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
                                            "Hasith Dulanjana",
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
                                                  color: Colors.yellow[800],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.symmetric( horizontal: 8),
                                                  child: Text(
                                                    "3.5(1K)",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w800,
                                                      color: AppData.primaryColor
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Reviews",
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
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
                                                      "Flowing : 18",
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
                                                      "Followers : 2",
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
                                    onTap: (){
                                      // widget.buttonClick();
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
                                          "Follow",
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
                    
                    Container(
                      height: _height - 228,
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

                            _viewContactDetails?AnimatedContainer(
                              duration: Duration(seconds:1),
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
                                            text:"078..........23",
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
                                            text:"hasith@gmail.com",
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
                                            text:"Samagipura, Mahabulankulama, Anuradhapura.",
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
                                            text:"lorem Excepteur eu tempor proident laborum minim nisi in esse commodo laboris. Est mollit nisi culpa in enim pariatur qui. Veniam dolor dolore quis est laboris elit ullamco ex ad sint pariatur minim magna nisi. Velit ut ex laboris esse velit consectetur ullamco dolor pariatur. Cupidatat deserunt enim veniam eu mollit ex id ipsum commodo ut aliqua id.",
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
                              children: [
                                ViewPost(post: Post()..id="1"..userTelNumber="077", user: null, listener: this,myPost: true,),
                                ViewPost(post: Post()..id="1"..userTelNumber="077", user: null, listener: this,myPost: true,),
                              ],
                            ),
                          ],
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
                            Icons.arrow_back_ios,
                            color: AppData.primaryColor,
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
    throw UnimplementedError();
  }

  @override
  goToLocation(location) {
    // TODO: implement goToLocation
    throw UnimplementedError();
  }

  @override
  moreClick(String postId) {
    // TODO: implement moreClick
    throw UnimplementedError();
  }

  @override
  moveToProfile(String userTelNumber) {
    // TODO: implement moveToProfile
    throw UnimplementedError();
  }

  @override
  sendMessage(String userTelNumber) {
    // TODO: implement sendMessage
    throw UnimplementedError();
  }

  @override
  takeCall(String userTelNumber) {
    // TODO: implement takeCall
    throw UnimplementedError();
  }

  @override
  canEdit(Post postId) {
    // TODO: implement moreClick
    throw UnimplementedError();
  }

  @override
  addToFavorite(String postId) {
    // TODO: implement moreClick
    throw UnimplementedError();
  }
}