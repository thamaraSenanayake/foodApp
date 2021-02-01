import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/viewLocation.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewPost extends StatefulWidget {
  final Post post;
  final User user;
  final bool myPost;
  final ViewPostListener listener;
  final bool canEdit;
  ViewPost({Key key,@required this.post,@required this.user, this.myPost = false,@required this.listener, this.canEdit = false}) : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  double _width = 0;
  double _reviewPercentage = 0.0;

  _call(String phone) async{
    
    var emailAddress = 'tel:'+phone;

    if(await canLaunch(emailAddress)) {
      await launch(emailAddress);
    }else{
      print("cant open dial");
    }   
  
  }

  _setReviewCount(){
    for (var item in widget.user.reviewList) {
      _reviewPercentage+= item.starCount;
    }if(widget.user.reviewList.length != 0){
      _reviewPercentage/=widget.user.reviewList.length;
    }
  }

  @override
  void initState() { 
    super.initState();
    _setReviewCount();
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
        // height: 467,
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
                    widget.post.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  !widget.canEdit? GestureDetector(
                    onTap: (){
                      Database().addRemoveFavorite(widget.post.id, widget.user);
                      if(widget.user.favoritePost.contains(widget.post.id)){
                        setState(() {
                          widget.user.favoritePost.remove(widget.post.id);
                        });
                      }else{
                        setState(() {
                          widget.user.favoritePost.add(widget.post.id);
                        });
                      }
                    },
                    child: Icon(
                      widget.user.favoritePost.contains(widget.post.id)?Icons.favorite:Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ):GestureDetector(
                    onTap: (){
                      widget.listener.canEdit(widget.post);
                    },
                    child: Icon(
                      Icons.edit,
                      color: AppData.secondaryColor,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                widget.post.city,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                "Rs: "+widget.post.price.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                "Amount: "+widget.post.amount.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                "Intend Date "+DateFormat.yMEd().format(widget.post.intendDate),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical:10.0),
              child: Text(
                "Description\n"+widget.post.description,
                // maxLines: 2,
                // overflow: TextOverflow.ellipsis,
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
                  image: NetworkImage(widget.post.imgUrl),
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
                                image: NetworkImage(widget.post.user.profilePicUrl),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.post.user.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  widget.user.reviewList.length != 0? Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow[800],
                                      ),
                                      Text(
                                        "$_reviewPercentage(${widget.user.reviewList.length})",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800
                                        ),
                                      ),
                                    ],
                                  ):Container()
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ):Container(),
                  GestureDetector(
                    onTap: () async {
                      bool clap = await Database().addClap(widget.post.clapUser, widget.user, widget.post);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(clap? "Add your clap":"You already clapped to this post"),
                          elevation:2
                        )
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Image.asset(
                          'assets/icon/clapping.png',
                        ),
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
                      // widget.listener.takeCall(widget.post.userTelNumber);
                      _call(widget.post.userTelNumber);
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
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, _, __) => ViewLocation(
                            location: widget.post.location,
                          ),
                          opaque: false
                        ),
                      );
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
                      Share.share(
                        widget.post.city+"\n"
                        "Rs: "+widget.post.price.toString()+"\n"
                        "Amount: "+widget.post.amount.toString()+"\n"
                        "Intend Date "+DateFormat.yMEd().format(widget.post.intendDate)+"\n"
                        "Description\n"+widget.post.description+"\n",
                        subject: widget.post.title
                      );
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      child: Icon(
                        Icons.share,
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
  canEdit(Post postId);
  addToFavorite(String postId);
}

//