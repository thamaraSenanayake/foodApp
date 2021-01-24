import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';

class MessageView extends StatefulWidget {
  final User user;
  MessageView({Key key,@required this.user}) : super(key: key);

  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  double _width = 0.0;
  double _height = 0.0;
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return SafeArea(
      child: Container(
        width: _width,
        color: Colors.orange,
                   
        )
    );
  }
}