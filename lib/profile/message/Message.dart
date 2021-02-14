import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/const.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/messageHead.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/messageHeader.dart';

import '../homeBase.dart';
import 'messageView.dart';

class MessageView extends StatefulWidget {
  final User user;
  final HomeBaseListener listener;
  MessageView({Key key,@required this.user, this.listener}) : super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  double _width = 0.0;
  double _height = 0.0;
  bool _loading = true;
  List<Widget> _headList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      // widget.listener.setPage(ProfilePage.Message);
      if(mounted){
        setState(() {
          AppData.msgCount = 0;
        });
      }
    });
    _loadMsgHeader();
  }

  _loadMsgHeader() async {
    List<Widget> _headListTemp = [];
    List<MessageHeader> messageHeaders= [];

    messageHeaders = await Database().getChatHeadList(widget.user);

    for (var item in messageHeaders) {
      User otherUser;
      if(item.user1 == widget.user.telNumber){
        otherUser = User()..telNumber = item.user2
        ..name = item.user2name
        ..profilePicUrl = item.user2ImgUrl;
      }else{
        otherUser = User()..telNumber = item.user1
        ..name = item.user1name
        ..profilePicUrl = item.user1ImgUrl;
      }
      _headListTemp.add(
        MessageHeaderView(user:widget.user,otherUser: otherUser,unReadCount: item.unreadMsgCount,)
      );
    }

    if(mounted){
      setState(() {
        _headList = _headListTemp;
        _loading = false;
      });
    }

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
        child: _loading? Container(
          color: Color.fromRGBO(128, 128, 128, 0.3),
          child: SpinKitDoubleBounce(
            color: AppData.thirdColor,
            size: 50.0,
          ),
        ):SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Message",
                style: TextStyle(
                  color: AppData.secondaryColor,
                  fontSize: 25,
                  fontWeight: FontWeight.w700
                ),
              ),

              SizedBox(
                height: 40,
              ),

              Column(
                children: _headList,
              )

              
            ],
          ),
        ),          
      )
    );
  }
}