import 'package:flutter/material.dart';
import 'package:food_app/model/message.dart';
import 'package:food_app/model/user.dart';
import 'package:intl/intl.dart';

import '../const.dart';

class SingleMessageView extends StatefulWidget {
  final User user;
  final SingleMessage singleMessage;
  SingleMessageView({Key key,@required this.user,@required this.singleMessage}) : super(key: key);

  @override
  _SingleMessageViewState createState() => _SingleMessageViewState();
}

class _SingleMessageViewState extends State<SingleMessageView> {
  double _width = 0.0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.only(bottom:5.0),
      child: Container(
        width: _width-20,
        child: Align(
          alignment: widget.user.telNumber == widget.singleMessage.userTelNumber? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.singleMessage.msg,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                    color: AppData.secondaryColor
                  ),
                ),
                Container(
                  child: Text(
                    DateFormat.jm().format(widget.singleMessage.dateTime),
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                      color: AppData.secondaryColor
                    ),
                  ),
                ),
              ],
            ),
            constraints: BoxConstraints(
              maxWidth: _width - 80,
              minHeight: 40
            ),
            padding:EdgeInsets.only(
              left:20 ,
              right:20,
              top:10,
              bottom: 10
            ),
            decoration: BoxDecoration(
              color: AppData.primaryColor,
              // color: Colors.white,
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
      ),
    );
  }
}