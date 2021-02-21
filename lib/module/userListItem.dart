import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';

import '../const.dart';

class UserListItem extends StatefulWidget {
  final User user;
  final UserListItemListener listener;
  // final List<User> userList;
  UserListItem({Key key,@required this.user,@required this.listener}) : super(key: key);

  @override
  _UserListItemState createState() => _UserListItemState();
}

class _UserListItemState extends State<UserListItem> {
  double _width = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: (){
          widget.listener.clickedUser(widget.user);
        },
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
              widget.user.profilePicUrl.isNotEmpty?
              // Container(
              //   height: 80,
              //   width: 80,
              //   decoration: BoxDecoration(
              //     image:DecorationImage(
              //       image: NetworkImage(widget.user.profilePicUrl),
              //       fit: BoxFit.cover,
              //     ) 
              //   ),
              // )
              CachedNetworkImage(
                imageUrl: widget.user.profilePicUrl,
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
              ):Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppData.secondaryColor,
                ),
                child:Center(
                  child: Text(
                    widget.user.name[0],
                    style: TextStyle(
                      fontSize: 35,
                      color: AppData.primaryColor,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                )
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
                      widget.user.name,
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
      ),
    );
  }
}

abstract class UserListItemListener{
  clickedUser(User user);
}