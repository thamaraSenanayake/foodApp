import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/post.dart';

import '../const.dart';

class NotificationItem extends StatefulWidget {
  final Post post;
  // final List<User> userList;
  NotificationItem({Key key,@required this.post}) : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  double _width = 0;
  String _clappedUserList = "";

  @override
  void initState() {
    if(widget.post.clapUser.isNotEmpty ){
      _clappedUserList += widget.post.clapUser.last.name;
      if(widget.post.clapUser.length > 1 ){
        _clappedUserList += " and "+(widget.post.clapUser.length -1).toString()+" others";
      }
    }
    _clappedUserList += " clapped to your post";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: _width - 40,
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
        child: Row(
          children: [

            CachedNetworkImage(
              imageUrl: widget.post.imgUrl[0],
              imageBuilder: (context, imageProvider) => Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider, 
                    fit: BoxFit.cover
                  ),
                ),
              ),
              placeholder: (context, url) => Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>( AppData.thirdColor,))),
              errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image,color: AppData.secondaryColor,)),
            ),
            
            Container(
              height: 80,
              width: _width - 140,
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _clappedUserList,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppData.secondaryColor
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}