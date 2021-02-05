import 'package:flutter/material.dart';
import 'package:food_app/model/review.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class ReviewView extends StatefulWidget {
  final Review review;
  ReviewView({Key key,@required this.review}) : super(key: key);

  @override
  _ReviewViewState createState() => _ReviewViewState();
}

class _ReviewViewState extends State<ReviewView> {
  double _width = 0.0;

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
                  widget.review.userName,
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
                      color:widget.review.starCount>0? Colors.yellow[800]:Colors.grey[800],
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>1? Colors.yellow[800]:Colors.grey[800],
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>2? Colors.yellow[800]:Colors.grey[800],
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>3? Colors.yellow[800]:Colors.grey[800],
                      size: 20,
                    ),
                    Icon(
                      Icons.star,
                      color:widget.review.starCount>4? Colors.yellow[800]:Colors.grey[800],
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
          ],
        ),
      ),
    );
  }
}