import 'package:flutter/material.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/viewPost.dart';
import 'package:food_app/profile/profile/editPost.dart';


class MyUploads extends StatefulWidget {
  final User user;
  MyUploads({Key key,@required this.user}) : super(key: key);

  @override
  _MyUploadsState createState() => _MyUploadsState();
}

class _MyUploadsState extends State<MyUploads> implements ViewPostListener {
  double _width = 0.0;
  double _height = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body: Container(
        width : _width,
        height :_height,
        child: SafeArea(
          child: Column(
            children: [

              //header
              Column(
                children: [
                  Container(
                    width : _width,
                    height: 50,
                    // color: Colors.red,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "My Uploads",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Container(
                height: _height - 128,
                width: _width,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ViewPost(post: Post()..id='011'..userTelNumber='088', user: widget.user, listener: this,myPost: true,canEdit: true,),
                      ViewPost(post: Post()..id='011'..userTelNumber='088', user: widget.user, listener: this,myPost: true,canEdit: true,)
                    ],
                  ),
                ),
              ),


            ],
          ),
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
  canEdit(Post post) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => EditPost(
          user: widget.user,
          post: post,
        ),
        opaque: false
      ),
    );
  }

  @override
  addToFavorite(String postId) {
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

}