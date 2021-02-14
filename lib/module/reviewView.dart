import 'package:flutter/material.dart';
import 'package:food_app/model/review.dart';
import 'package:food_app/module/textbox.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class ReviewView extends StatefulWidget {
  final Review review;
  final Function(Review newReview ,Review oldReview) submitReview;
  final bool replyView;
  ReviewView({Key key,@required this.review,@required this.submitReview, this.replyView = false }) : super(key: key);

  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  double _width = 0.0;
  String _reply = "";
  Review oldReview;


  _submitReply(){
    FocusScope.of(context).unfocus();
    Review newReview = Review()
    ..review = widget.review.review
    ..starCount = widget.review.starCount
    ..userTelNumber = widget.review.userTelNumber
    ..userName = widget.review.userName
    ..dateTime = widget.review.dateTime
    ..reply = _reply
    ..read = widget.review.read
    ..replyTime = DateTime.now();

    widget.submitReview(newReview,oldReview);
  }
  @override
  void initState() {
    super.initState();
    oldReview = widget.review;
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        width: _width-20,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppData.primaryColor,
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
                  widget.review.userName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppData.secondaryColor
                  ),
                ),
                Text(
                  DateFormat.yMEd().format(widget.review.dateTime),
                  style: TextStyle(
                    fontSize: 15,
                    // fontWeight: FontWeight.w500,
                    color: AppData.secondaryColor,
                  ),
                ),

              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Container(
                height: 30,
                width: _width -40,
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>0? AppData.thirdColor:Colors.grey[800],
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>1? AppData.thirdColor:Colors.grey[800],
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>2? AppData.thirdColor:Colors.grey[800],
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>3? AppData.thirdColor:Colors.grey[800],
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>4? AppData.thirdColor:Colors.grey[800],
                      size: 20,
                    )
                  ],
                ),
              ),
            ),
            Text(
              widget.review.review,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                color: AppData.secondaryColor
              ),
            ),
            
           widget.replyView && (widget.review.reply == null || widget.review.reply.length ==0)?  Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:15.0),
                  child: TextBox(
                    textBoxKey: null, 
                    onChange: (val){
                      _reply = val;
                    }, 
                    errorText: "",
                    textBoxHint: "send reply...",
                    shadowDisplay: false,
                    textInputType: TextInputType.multiline
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: (){
                      _submitReply();
                    },
                    child: Container(
                      width: 100,
                      height: 30,
                      child: Center(
                        child: Text(
                          "Submit",
                          style:TextStyle(
                            fontWeight: FontWeight.w700
                          )
                        )
                      ),
                      decoration: BoxDecoration(
                        // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
                        color: Colors.white,
                        border: Border.all(
                          color: AppData.secondaryColor,
                          width: 3
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                )
              ],
            ):widget.review.reply != null ?Padding(
              padding: const EdgeInsets.only(top:8,left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Reply",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppData.secondaryColor
                    ),
                  ),
                  Text(
                    widget.review.reply,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppData.secondaryColor
                    ),
                  ),
                  Text(
                    DateFormat.yMEd().format(widget.review.replyTime),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppData.secondaryColor
                    ),
                  ),
                ],
              ),
            ):SizedBox(),
          ],
        ),
      ),
    );
  }
}