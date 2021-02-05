import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/viewPost.dart';
import 'package:food_app/profile/userProfilePage.dart';

import '../const.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements ViewPostListener{
  double _width = 0.0;
  List<Post> _post = [];
  List<Widget> _postViewList = [];
  bool _loading = true;

  @override
  void initState() { 
    super.initState();
    _loadData();
  }

  _loadData() async {
    List<Widget> postViewList = [];
    _post = await Database().getPostList(widget.user); 
    for (var item in _post) {
      postViewList.add(
        ViewPost(post: item, user: widget.user, listener: this)
      );
    }
    setState(() {
      _postViewList = postViewList;
       _loading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return _loading? Container(
        color: Color.fromRGBO(128, 128, 128, 0.3),
        child: SpinKitSquareCircle(
          color: AppData.secondaryColor,
          size: 50.0,
        ),
      ):Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        child:Container(
          width: _width,
          child: Column(
            children: _postViewList,
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
  addToFavorite(String postId) {
    // TODO: implement moreClick
    throw UnimplementedError();
  }

  @override
  moveToProfile(String userTelNumber) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => UserProfilePage(
          user: widget.user, otherUserId: userTelNumber,
        ),
        opaque: false
      ),
    );
  }

  @override
  canEdit(Post postId) {
    // TODO: implement moreClick
    throw UnimplementedError();
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