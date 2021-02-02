import 'package:flutter/material.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/textbox.dart';
import 'package:food_app/module/viewPost.dart';

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
  
  _search(String searchKey) async {
    List<Widget> viewPost = [];
    viewPost = [];
    List<Post> _post = await Database().searchPostList(searchKey, _radioValues ==1?true:false);
    for (var item in _post) {
      viewPost.add(
        ViewPost(post: item, user: widget.user, listener: this)
      );
    }
    setState(() {
      _viewPost = viewPost;
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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextBox(
              textBoxKey: null, 
              onChange: null, 
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
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
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
                    color: Colors.white,
                    child: RadioListTile(
                      title:  Text(
                        'Sell',
                        style: TextStyle(
                          color: Colors.grey
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
                      title:  Text(
                        'Buy',
                        style: TextStyle(
                          color: Colors.grey
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

            Container(
              height: _height - 337,
              width: _width,
              child: SingleChildScrollView(
                child: Column(
                  children: _viewPost,
                ),
              ),
            )
          ],
        ),
      )
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