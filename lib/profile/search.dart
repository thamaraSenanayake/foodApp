import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/textbox.dart';
import 'package:food_app/module/viewPost.dart';
import 'package:food_app/profile/userProfilePage.dart';

import '../const.dart';

class SearchScreen extends StatefulWidget {
  final User user;
  SearchScreen({Key key,@required this.user}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> implements ViewPostListener{
  double _width = 0.0;
  double _height = 0.0;
  int _radioValues = 1;
  List<Widget> _viewPost = [];
  bool _loading = false;
  bool _noResult = false;
  _search(String searchKey) async {
    if(searchKey.isEmpty){
      return;
    }
    List<Widget> viewPost = [];
    setState(() {
      _loading = true;
      _noResult = false;
    });
    viewPost = [];
    List<Post> _post = await Database().searchPostList(searchKey, _radioValues ==1?true:false,widget.user.telNumber);
    for (var item in _post) {
      viewPost.add(
        ViewPost(post: item, user: widget.user, listener: this)
      );
    }

    if(viewPost.length == 0){
      setState(() {
        _noResult = true;
      });
    }

    setState(() {
      _viewPost = viewPost;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return SafeArea(
      child: Container(
        width: _width,
        // color: Colors.yellow,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextBox(
                textBoxKey: null, 
                onChange: (val){
                  
                }, 
                errorText: "",
                textBoxHint: "Search",
                prefixIcon: Icons.search,
                onSubmit: (val){
                  print("onSubmit");
                  _search(val);
                },
              ),
              SizedBox(
                height:20
              ),
              Container(
                width: _width-40,
                height: 50,
                decoration: BoxDecoration(
                  // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
                  color: AppData.primaryColor,
                  border: Border.all(
                    color: AppData.primaryColor,
                    width: 3
                  ),
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
                  children: [
                    Container(
                      width: (_width-46)/2,
                      child: RadioListTile(
                        activeColor: AppData.thirdColor,
                        title:  Text(
                          'Sell',
                          style: TextStyle(
                            color: AppData.secondaryColor
                          ),
                        ),
                        value: 1,
                        groupValue: _radioValues,
                        onChanged: ( value) {
                          setState(() {
                            _radioValues = value;
                          });
                        },
                      ),
                    ),
                    Container(
                      width: (_width-46)/2,
                      // height: 50,
                      child: RadioListTile(
                        activeColor: AppData.thirdColor,
                        title:  Text(
                          'Buy',
                          style: TextStyle(
                            color: AppData.secondaryColor
                          ),
                        ),
                        value: 2,
                        groupValue: _radioValues,
                        onChanged: ( value) {
                          setState(() {
                            _radioValues = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height:20
              ),

              _loading?Container(
                height: _height-128,
                child: SpinKitDoubleBounce(
                  color: AppData.thirdColor,
                  size: 50.0,
                ),
              ):_noResult?
                Center(
                  child: Text(
                    "No post on your search",
                    style: TextStyle(
                      color: AppData.secondaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                ): Container(
                width: _width,
                child: Column(
                  children: _viewPost,
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  @override
  addToFavorite(String postId) {
      // TODO: implement addToFavorite
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
      // TODO: implement sendMessage
    }
  
    @override
    takeCall(String userTelNumber) {
    // TODO: implement takeCall
  }
  @override
  delete(Post post) async{
  }
}