import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';

import '../../const.dart';

class MessageScreen extends StatefulWidget {
  final User user;
  MessageScreen({Key key,@required this.user}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ScrollController _controller;
  List<Widget> _msgListWidget = [];
  double _height =0.0;
  double _width =0.0;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController(
      initialScrollOffset: 0.0,
      keepScrollOffset: true,
    );
  }

  _loadMsg() async {
    
    

    
    _controller.animateTo(
      0.0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
    
    // _c
    // _controller = ScrollController(
    //   initialScrollOffset: 0.0,
    //   keepScrollOffset: true,
    // );
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
                              Navigator.pop(context);
                            },
                            child: Container(
                              width: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left:10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: AppData.primaryColor,
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
                                  "Hasith Dulanjana",
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical:6.0),
                        child: SingleChildScrollView(
                          reverse: true,
                          controller: _controller,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // children: _msgListWidget,
                            children: [
                              Container(
                                width: _width-20,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Container(
                                    child: Text(
                                      "data"
                                    ),
                                    constraints: BoxConstraints(
                                      maxWidth: _width - 80,
                                      minHeight: 40
                                    ),
                                    padding:EdgeInsets.only(
                                      left:20 ,
                                      right:20,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
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
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: _width,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        border:Border(
                          top: BorderSide(width: 2.0, color: Colors.grey[500]),
                        )
                      ),
                      child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 60),
                        child: TextField(
                          style: TextStyle(color: Colors.black, fontSize: 15),
                          // controller: _messageController,
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
                            // _sendMsg();
                          },
                        ),
                      ) ,
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