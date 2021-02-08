import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/message/messageView.dart';

import '../const.dart';

class MessageHeaderView extends StatefulWidget {
  final User user;
  final User otherUser;
  MessageHeaderView({Key key,@required this.user,@required this.otherUser}) : super(key: key);

  @override
  _MessageHeaderViewState createState() => _MessageHeaderViewState();
}

class _MessageHeaderViewState extends State<MessageHeaderView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, _, __) => MessageScreen(
              user: widget.user,
              otherUser: widget.otherUser,
            ),
            opaque: false
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 100,
        padding:EdgeInsets.only(
          left:20,
          right:20
        ),
        decoration: BoxDecoration(
          // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  100
                ),
                border: Border.all(
                  width: 2,
                ),
                image: DecorationImage(
                  image: NetworkImage(widget.otherUser.profilePicUrl),
                  fit: BoxFit.cover,
                )
              ),
            ),
            Text(
              widget.otherUser.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppData.secondaryColor,
                borderRadius: BorderRadius.circular(3),
              ),
              child:Text(
                "3",
                style: TextStyle(
                  color: AppData.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w700
                ),
              ),

            )
          ],
        ),
      ),
    );
  }
}