import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/model/user.dart';

import 'messageView.dart';

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
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "Message",
              style: TextStyle(
                color: AppData.secondaryColor,
                fontSize: 25,
                fontWeight: FontWeight.w700
              ),
            ),

            SizedBox(
              height: 40,
            ),

            GestureDetector(
              onTap: (){
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, _, __) => MessageScreen(
                      user: widget.user,
                    ),
                    opaque: false
                  ),
                );
              },
              child: Container(
                width: _width - 40,
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
                          width: 2
                        ),
                        image: DecorationImage(
                          image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeabWkXTrS3TpRsbQ3ugejErdv4lfff8FgPw&usqp=CAU'),
                          fit: BoxFit.cover,
                        )
                      ),
                    ),
                    Text(
                      "Hasith Dulanjana",
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
            )
          ],
        ),          
      )
    );
  }
}