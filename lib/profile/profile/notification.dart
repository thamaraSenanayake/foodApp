import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/notificationItem.dart';

import '../../const.dart';


class NotificationScreen extends StatefulWidget {
  final User user;
  NotificationScreen({Key key,@required this.user}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>  {
  double _width = 0.0;
  double _height = 0.0;
  List<Widget> _clapList = [];
  List<Post> _postList = [];
  bool _loading = true;

  _getClapPosts() async {
    List<Widget> clapList = [];

    _postList =await Database().getClappedPost(widget.user);
    for (var item in _postList) {
      clapList.add(
        NotificationItem(post: item)
      );
    }

    setState(() {
      _clapList = clapList;
      _loading = false;
    });
    Database().resetClapCount(widget.user.telNumber);

  }

  @override
  void initState() {
    super.initState();
    _getClapPosts();
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
                            "Notification",
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

              Expanded(
                child: Container(
                  child:_loading?SpinKitSquareCircle(
                    color: AppData.thirdColor,
                    size: 50.0,
                    ): SingleChildScrollView(
                    child:_clapList.length ==0?
                    Center(
                      child: Text(
                        "No notification show here..",
                        style: TextStyle(
                          color: AppData.secondaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ): Column(
                      children: _clapList,
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

}