import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/viewPost.dart';

import '../../const.dart';


class FavoriteScreen extends StatefulWidget {
  final User user;
  FavoriteScreen({Key key,@required this.user}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> implements ViewPostListener {
  double _width = 0.0;
  double _height = 0.0;
  List<Widget> _favoriteList = [];
  List<Post> _postList = [];
  bool _loading = true;

  _getFavoritePosts() async {
    List<Widget> favoriteList = [];
    _postList =await Database().getFavorite(widget.user);
    for (var item in _postList) {
      favoriteList.add(
        ViewPost(post: item, user: widget.user, listener: this)
      );
    }

    setState(() {
      _favoriteList = favoriteList;
      _loading = false;
    });


  }

  @override
  void initState() {
    super.initState();
    _getFavoritePosts();
  }

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
                            "Favorites",
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

              _loading?Container(
                height: _height - 128,
                color: Color.fromRGBO(128, 128, 128, 0.3),
                child: SpinKitSquareCircle(
                  color: AppData.secondaryColor,
                  size: 50.0,
                ),
              ): Container(
                height: _height - 128,
                child: SingleChildScrollView(
                  child: Column(
                    children:_favoriteList,
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
  addToFavorite(String postId) {
    // TODO: implement addToFavorite
    throw UnimplementedError();
  }

  @override
  canEdit(Post postId) {
    // TODO: implement canEdit
    throw UnimplementedError();
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

}