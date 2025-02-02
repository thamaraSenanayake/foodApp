import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/viewPost.dart';
import 'package:food_app/profile/profile/editPost.dart';
import 'package:food_app/res/convert.dart';

import '../../const.dart';
import '../userProfilePage.dart';


class PostsToCategory extends StatefulWidget {
  final User user;
  final UserCategory category;
  PostsToCategory({Key key,@required this.user,@required this.category}) : super(key: key);

  @override
  _PostsToCategoryState createState() => _PostsToCategoryState();
}

class _PostsToCategoryState extends State<PostsToCategory> implements ViewPostListener {
  double _width = 0.0;
  double _height = 0.0;
  List<Widget> _postViewList = [];
  List<Post> _postList = [];
  bool _loading = true;
  String _title = "";
  
  _loadPost() async {
    List<Widget> postViewList = [];
    _postList = await Database().getPostToCategory(widget.user,widget.category);

    for (var item in _postList) {
      postViewList.add(
        ViewPost(post: item, user: widget.user, listener: this,myPost: false,canEdit: false,),
      );
    }
    if(mounted){
      setState(() {
        _postViewList =postViewList;
        _loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _title = categoryToString(widget.category);
    _loadPost();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body: Container(
        color: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
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
                                  color: AppData.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            _title,
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

              Expanded(
                child: Container(
                  width: _width,
                  child: _loading?SpinKitDoubleBounce(
                    color: AppData.thirdColor,
                    size: 50.0,
                    ):_postViewList.length ==0?
                    Center(
                      child: Text(
                        "No posts yet..",
                        style: TextStyle(
                          color: AppData.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ):
                    SingleChildScrollView(
                      child: Column(
                        children: _postViewList,
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
  canEdit(Post post) async{
  }

  @override
  delete(Post post) async{
  }

  @override
  addToFavorite(String postId) {
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
    // TODO: implement sendMessage
  }

  @override
  takeCall(String userTelNumber) {
    // TODO: implement takeCall
  }

}