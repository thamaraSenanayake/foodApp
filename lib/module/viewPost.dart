import 'package:flutter/material.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';

class ViewPost extends StatefulWidget {
  final Post post;
  final User user;
  final bool myPost;
  final ViewPostListener listener;
  ViewPost({Key key,@required this.post,@required this.user, this.myPost = false,@required this.listener}) : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  double _width = 0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        width: _width-20,
        height: 467,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: <BoxShadow>[
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
        child:Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Title/Boiler",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Icon(
                    Icons.favorite,
                    color: Colors.red,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                "Place/Anuradhapura.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                "Price/Not fixed.",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                "Amount/Between 500/600KG",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                "Intend Date/2021/05/00",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical:10.0),
              child: Text(
                "Description https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),

            Container(
              height: 200,
              width: _width-20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                  image: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg'),
                  fit: BoxFit.cover,
                )
              ),
            ),

            SizedBox(
              height: 20,
            ),

            

            Container(
              height: 60,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  !widget.myPost? GestureDetector(
                    onTap: (){
                      widget.listener.moveToProfile(widget.post.userTelNumber);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(100),
                              image: DecorationImage(
                                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeabWkXTrS3TpRsbQ3ugejErdv4lfff8FgPw&usqp=CAU'),
                                fit: BoxFit.cover,
                              )
                            )
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            height: 60,
                            constraints:BoxConstraints(
                              maxWidth: _width -310
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  Text(
                                    "Description https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[800],
                                      ),
                                      Text(
                                        "3.5(1K)",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ):Container(),
                  GestureDetector(
                    onTap: (){
                      widget.listener.clap(widget.post.id);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.star,
                        size: 25,
                        color: Colors.yellow,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.listener.sendMessage(widget.post.userTelNumber);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.message,
                        size: 25,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.listener.takeCall(widget.post.userTelNumber);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.call,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      // widget.listener.goToLocation(location)
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.location_on,
                        size: 25,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.listener.moreClick(widget.post.id);
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.more_vert,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            )
            
          ],
        ),
      ),
    );
  }
}

abstract class ViewPostListener{
  moveToProfile(String userTelNumber);
  clap(String postId);
  sendMessage(String userTelNumber);
  takeCall(String userTelNumber);
  goToLocation(location);
  moreClick(String postId);
}