import 'package:flutter/material.dart';
import 'package:food_app/model/review.dart';
import 'package:food_app/model/user.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class AddReview extends StatefulWidget {
  final User user;
  AddReview({Key key,@required this.user}) : super(key: key);

  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  List<Widget> _reviewListWidget = [];
  double _height =0.0;
  double _width =0.0;
  TextEditingController _reviewController = TextEditingController();
  List<Review> _review = [];
  int _starCount = 5;
  @override
  void initState() {
    super.initState();
  }

  _loadMsg() async {
    
  }

  _addReview(){
    String text = _reviewController.text;
    _reviewController.text = '';
    List<Widget> _reviewListWidgetTemp = [];
    if(text.isNotEmpty){
      _review.add(
        Review()
        ..userTelNumber = widget.user.telNumber
        ..review = text
        ..starCount = _starCount
        ..userName = widget.user.name
        ..dateTime = DateTime.now()
      );
    }

    for (var item in _review) {
      // _reviewListWidgetTemp.add(
        // SingleMessageView(singleMessage: item, user: widget.user,)
      // );
    }

    setState(() {
      _reviewListWidget = _reviewListWidgetTemp;
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
                                  "Review",
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // children: _reviewListWidget,
                            children: [
                              Container(
                                width: _width-20,
                                padding: EdgeInsets.all(10),
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Supun Perera",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppData.secondaryColor
                                          ),
                                        ),
                                        Text(
                                          DateFormat.yMEd().format(DateTime.now()),
                                          style: TextStyle(
                                            fontSize: 15,
                                            // fontWeight: FontWeight.w500,
                                            color: AppData.secondaryColor
                                          ),
                                        ),

                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Container(
                                        height: 30,
                                        width: _width -40,
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[800],
                                              size: 20,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[800],
                                              size: 20,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[800],
                                              size: 20,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[800],
                                              size: 20,
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Colors.yellow[800],
                                              size: 20,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "Eiusmod laboris veniam id in. Incididunt exercitation sunt fugiat id eiusmod. Amet elit consequat dolor veniam incididunt voluptate est in commodo ullamco tempor duis. Exercitation culpa laborum duis proident cupidatat deserunt et aute Lorem. Sint incididunt dolor veniam anim ex exercitation.",
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400,
                                        color: AppData.secondaryColor
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: _width,
                          height: 50,
                          padding: EdgeInsets.symmetric(horizontal:10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Text(
                                "Select Star count",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppData.secondaryColor
                                ),
                              ),
                              Container(
                                width: _width - 200,
                                height: 50,
                                child:Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _starCount = 1;
                                        });
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color:_starCount>0? Colors.yellow[800]:Colors.grey[800],
                                      ),
                                    ),

                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _starCount = 2;
                                        });
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color:_starCount>1? Colors.yellow[800]:Colors.grey[800],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _starCount = 3;
                                        });
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color:_starCount>2? Colors.yellow[800]:Colors.grey[800],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _starCount = 4;
                                        });
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color:_starCount>3? Colors.yellow[800]:Colors.grey[800],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _starCount = 5;
                                        });
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color:_starCount>4? Colors.yellow[800]:Colors.grey[800],
                                      ),
                                    ),

                                  ],
                                )
                              )
                            ]
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
                              controller: _reviewController,
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
                                _addReview();
                              },
                            ),
                          ) ,
                        ),
                      ],
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