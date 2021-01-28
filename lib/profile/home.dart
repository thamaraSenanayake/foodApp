import 'package:flutter/material.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/viewPost.dart';
import 'package:food_app/profile/userProfilePage.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements ViewPostListener{
  double _width = 0.0;
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child: Container(
          width: _width,
          child: Column(
            children: [
              ViewPost(post: Post()..id="1"..userTelNumber="077", user: null, listener: this),
              ViewPost(post: Post()..id="1"..userTelNumber="077", user: null, listener: this),
              
            ],
          ),
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
    throw UnimplementedError();
  }

  @override
  moreClick(String postId) {
    // TODO: implement moreClick
  }

  @override
  moveToProfile(String userTelNumber) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => UserProfilePage(
          user: widget.user,
        ),
        opaque: false
      ),
    );
  }

  @override
  sendMessage(String userTelNumber) {
    // TODO: implement sendMessage
  }

  @override
  takeCall(String userTelNumber) {
  // TODO: implement takeCall
  }
}