import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/review.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/reviewView.dart';

import '../../const.dart';

class ViewReview extends StatefulWidget {
  final User user;
  ViewReview({Key key,@required this.user,}) : super(key: key);

  @override
  _ViewReviewState createState() => _ViewReviewState();
}

class _ViewReviewState extends State<ViewReview> {
  List<Widget> _reviewListWidget = [];
  double _height =0.0;
  double _width =0.0;
  bool _loading =false;
  @override
  void initState() {
    super.initState();
    _loadReview();
  }

  _loadReview()  {
    List<Widget> reviewListWidget = [];
    for (var item in widget.user.reviewList) {
     reviewListWidget.add(
      ReviewView(
        review: item,
        submitReview: (Review newReview  ,Review  oldReview) async { 
          if(mounted){
            setState(() {
              _loading = true;
            });
          } 
          int index = widget.user.reviewList.indexOf(oldReview);
          widget.user.reviewList.remove(oldReview);
          widget.user.reviewList.insert(index,newReview);
          await Database().updateReview(widget.user.reviewList, widget.user);
          _loadReview(); 
        },
        replyView :true,
      )
    );
    }
    if(mounted){
      setState(() {
        _reviewListWidget = reviewListWidget;
        _loading = false;
      });
    }
    Database().updateReview(widget.user.reviewList, widget.user,readAll: true);
    if(mounted){
      setState(() {
        AppData.reviewCount = 0;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: Container(
        color: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
        height:_height,
        width:_width,
        child: Stack(
          children: [

            // Align(
            //   alignment: Alignment.topCenter,
            //   child: Container(
            //     width: _width,
            //     height: 50,
            //     color: AppData.secondaryColor,
            //   ),
            // ),

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
                        // color: AppData.secondaryColor,
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
                                    Icons.arrow_back,
                                    color: AppData.secondaryColor,
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
                                  "View Feedback",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppData.secondaryColor
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
                      child:_loading ?Container(
                        width: _width,
                        color:AppData.secondaryColor.withOpacity(0.8) ,
                        child: SpinKitDoubleBounce(
                          color: AppData.thirdColor,
                          size: 50.0,
                        ),
                      ): Padding(
                        padding: const EdgeInsets.symmetric(vertical:6.0),
                        child:_reviewListWidget.length == 0? Center(
                          child: Text(
                            "No Reviews from your uses..",
                            style: TextStyle(
                              color: AppData.secondaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ): SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            // children: _reviewListWidget,
                            children: _reviewListWidget,
                          ),
                        ),
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