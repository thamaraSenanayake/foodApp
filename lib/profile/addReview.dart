import 'package:flutter/material.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/review.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/reviewView.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class AddReview extends StatefulWidget {
  final User otherUser;
  final User user;
  AddReview({Key key,@required this.user,@required this.otherUser}) : super(key: key);

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
    _loadReview();
  }


  _loadReview()  {
    List<Widget> reviewListWidget = [];
    for (var item in widget.otherUser.reviewList) {
      reviewListWidget.add(
        ReviewView(
          review: item, 
          submitReview: (Review newReview ,Review oldReview ) {  
          
          },
        )
      );
    }
    setState(() {
      _reviewListWidget = reviewListWidget;
    });
  }

  _addReview(){
    String text = _reviewController.text;
    _reviewController.text = '';
    if(text.isNotEmpty){
      widget.otherUser.reviewList.add(
        Review()
        ..userTelNumber = widget.user.telNumber
        ..review = text
        ..starCount = _starCount
        ..userName = widget.user.name
        ..dateTime = DateTime.now()
      );
    }
    Database().updateReview(widget.otherUser.reviewList, widget.otherUser);
    _loadReview(); 

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
                            children: _reviewListWidget,
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
                                        color:_starCount>0? AppData.thirdColor:Colors.grey[800],
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
                                        color:_starCount>1? AppData.thirdColor:Colors.grey[800],
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
                                        color:_starCount>2? AppData.thirdColor:Colors.grey[800],
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
                                        color:_starCount>3? AppData.thirdColor:Colors.grey[800],
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
                                        color:_starCount>4? AppData.thirdColor:Colors.grey[800],
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