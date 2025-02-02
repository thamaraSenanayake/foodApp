import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/viewPost.dart';
import 'package:food_app/profile/message/messageView.dart';

import '../../const.dart';
import '../userProfilePage.dart';


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
    if(mounted){
      setState(() {
        _favoriteList = favoriteList;
        _loading = false;
      });
    }


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
        color: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
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
                                  color: AppData.secondaryColor,
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
                              fontWeight: FontWeight.w800,
                              color: AppData.secondaryColor,
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
                child: SpinKitDoubleBounce(
                  color: AppData.thirdColor,
                  size: 50.0,
                ),
              ):_favoriteList.length == 0? Expanded(
                child: Center(
                  child: Text(
                    "Not added any favorite post yet",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                ),
              ): Expanded(
                child: Container(
                  // color: Colors.red,
                  child: SingleChildScrollView(
                    child: Column(
                      children:_favoriteList,
                    ),
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
    List<Widget> favoriteList = [];
    Post _post = _postList.firstWhere((val)=>val.id==postId, orElse: () => null);
    
    _postList.remove(_post);

    if(mounted){
      setState(() {
        _favoriteList = favoriteList;
      });
    }
  }

  @override
  canEdit(Post postId) {
    // TODO: implement canEdit
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
  sendMessage(User otherUser) {
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
  takeCall(String userTelNumber) {
  // TODO: implement takeCall
  }

  @override
  delete(Post post) async{
  }

}