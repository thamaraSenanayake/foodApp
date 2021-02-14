import 'package:flutter/material.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/addPost/addPost.dart';

import '../../const.dart';


class EditPost extends StatefulWidget {
  final User user;
  final Post post;
  EditPost({Key key,@required this.user,@required this.post}) : super(key: key);

  @override
  _EditPostState createState() => _EditPostState();
}

class _EditPostState extends State<EditPost>  {
  double _width = 0.0;
  double _height = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            "Edit Post",
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

              Container(
                height: _height - 128,
                child: SingleChildScrollView(
                  child: AddPost(user: widget.user, post: widget.post,listener: null,),
                ),
              ),

              Container()

            ],
          ),
        ),
      ),
    );
  }

}