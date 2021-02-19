import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/userListItem.dart';
import '../../const.dart';
import '../userProfilePage.dart';


class UserList extends StatefulWidget {
  final List<String> userList;
  final String title;
  final User user;
  UserList({Key key,@required this.userList,@required this.title,@required this.user}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}

class _UserListState extends State<UserList> implements UserListItemListener {
  double _width = 0.0;
  double _height = 0.0;
  List<Widget> _userViewList = [];
  List<User> _userList = [];
  User user;
  bool _loading = true;

  _getUsersList() async {
    List<Widget> userViewList = [];
    _userList =await Database().getUserList(widget.userList);
    for (var item in _userList) {
      userViewList.add(
        UserListItem( user: item, listener: this)
      );
    }
    if(mounted){
      setState(() {
        _userViewList = userViewList;
        _loading = false;
      });
    }



  }

  @override
  void initState() {
    super.initState();
    _getUsersList();
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
                            widget.title,
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
              ):_userViewList.length == 0? Expanded(
                child: Center(
                  child: Text(
                    "No ${widget.title} yet",
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
                      children:_userViewList,
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
  clickedUser(User user) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, _, __) => UserProfilePage(
          user: widget.user, otherUserId: user.telNumber,
        ),
        opaque: false
      ),
    );
  }

}