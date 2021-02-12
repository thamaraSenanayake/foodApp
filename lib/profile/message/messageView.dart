import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/message.dart';
import 'package:food_app/model/messageHead.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/singleMessageView.dart';

import '../../const.dart';

class MessageScreen extends StatefulWidget {
  final User user;
  final User otherUser;
  MessageScreen({Key key,@required this.user,@required this.otherUser}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ScrollController _controller;
  List<Widget> _msgListWidget = [];
  double _height =0.0;
  double _width =0.0;
  TextEditingController _messageController = TextEditingController();
  MessageHeader _messageHeader = MessageHeader();
  bool _loading = true; 
  bool _firstLoad = true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      _loadMsg();
    });
  }

  _loadMsg() async {
    List<Widget> _msgListWidgetTemp = [];
    _messageHeader = await Database().getMessageHeadData(widget.user, widget.otherUser);

    for (var item in _messageHeader.msgList) {
      _msgListWidgetTemp.add(
        SingleMessageView(singleMessage: item, user: widget.user,)
      );
    }

    setState(() {
      _msgListWidget = _msgListWidgetTemp;
      _loading = false;
    });

    _controller.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );

    await Database().setLastRead(_messageHeader, widget.user);
    _msgListener();
    // _c
    // _controller = ScrollController(
    //   initialScrollOffset: 0.0,
    //   keepScrollOffset: true,
    // );
  }

  _msgListener(){
    List<Widget> _msgListWidgetTemp = [];

    List<MessageHeader> messageHeader;
    CollectionReference msgList = Database().msgReference;
    msgList
    .where('headName',isEqualTo: _messageHeader.headName)
    .snapshots().listen((querySnapshot) {
      messageHeader = Database().setMessageHeader(querySnapshot,widget.user);
      if(messageHeader != null && !_firstLoad){
        print("listner");
        List<SingleMessage> msgList = [];

        for (var item in messageHeader) {
          msgList = item.msgList;
        }

        
        
        if(msgList.last.userTelNumber != widget.user.telNumber){
          _messageHeader.msgList.add(msgList.last);
          for (var item in _messageHeader.msgList) {
            _msgListWidgetTemp.add(
              SingleMessageView(singleMessage: item, user: widget.user,)
            );
          }
          if(mounted){
            setState(() {
              _msgListWidget = _msgListWidgetTemp;
            });
          }
        }
        
      }else{
        if (_firstLoad) {
          _firstLoad = false;
        }
      }
    });

  }

  _sendMsg(){
    String text = _messageController.text;
    List<Widget> _msgListWidgetTemp = [];

    _messageController.text = '';
    if(text.isNotEmpty){
      if(_messageHeader.msgList == null ){
        _messageHeader.msgList = [];  
      }
      _messageHeader.msgList.add(
        SingleMessage()
        ..userTelNumber = widget.user.telNumber
        ..msg = text
        ..dateTime =DateTime.now()
      );
    }

    Database().sendMsg(_messageHeader.msgList, _messageHeader.headName);

    for (var item in _messageHeader.msgList) {
      _msgListWidgetTemp.add(
        SingleMessageView(singleMessage: item, user: widget.user,)
      );
    }

    setState(() {
      _msgListWidget = _msgListWidgetTemp;
    });

  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: Container(
        height:_height,
        width:_width,
        child: Stack(
          children: [
            _loading? Container(
              height:_height,
              width:_width,
              color: Color.fromRGBO(128, 128, 128, 0.3),
              child: SpinKitSquareCircle(
                color: AppData.thirdColor,
                size: 50.0,
              ),
            ):Container(),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: _width,
                height: 50,
                color: AppData.secondaryColor,
              ),
            ),

            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     width: _width,
            //     height: 40,
            //     color: AppData.secondaryColor,
            //   ),
            // ),
        
            Container(
              height:_height,
              width:_width,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      width: _width,
                      decoration: BoxDecoration(
                        color: AppData.secondaryColor,
                      ),
                      child: Stack(
                        children: [
                          GestureDetector(
                            onTap: (){
                              Database().setLastRead(_messageHeader, widget.user);
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left:10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: AppData.primaryColor,
                                    size: 35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: _width - 100,
                              height: 40,
                              child: Padding(
                                padding: EdgeInsets.only(top:8.0),
                                child: Text(
                                  widget.otherUser.name,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppData.primaryColor
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ),
                          ),
                        ],
                      ),  
                    ),
                    Expanded(
                      child: Container(
                        width: _width,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical:6.0),
                          child: SingleChildScrollView(
                            reverse: true,
                            controller: _controller,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: _msgListWidget,
                              // children: [
                                
                              // ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _width,
                      height: 50,
                      decoration: BoxDecoration(
                        border:Border(
                          top: BorderSide(width: 2.0, color: Colors.grey[500]),
                        )
                        // color: Colors.red,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: _width-50,
                            height: 50,
                            child:Padding(
                              padding: const EdgeInsets.only(left: 30,right:30),
                              child: TextField(
                                style: TextStyle(color: Colors.black, fontSize: 15),
                                controller: _messageController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Type something...",
                                  // prefixIcon: Icon(Icons.person_outline),
                                  hintStyle: TextStyle(
                                    fontSize: 15,
                                    // fontWeight: FontWeight.w700,
                                    color: Color(0xffB3A9A9),
                                    height: 1.1
                                  ),
                                ),
                                keyboardType: TextInputType.text,
                                onChanged: (value){
                                  // _removeTitleError();
                                },
                                onSubmitted: (val){
                                  _sendMsg();
                                },
                              ),
                            ) ,
                          ),
                          GestureDetector(
                            onTap: (){
                              _sendMsg();
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.send,
                                color: AppData.secondaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ]
        )
      )
    );
  }
}