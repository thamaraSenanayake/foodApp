import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/message/messageView.dart';

import '../const.dart';

class MessageHeaderView extends StatefulWidget {
  final User user;
  final User otherUser;
  final int unReadCount;
  MessageHeaderView({Key key,@required this.user,@required this.otherUser,@required this.unReadCount}) : super(key: key);

  @override
  _MessageHeaderViewState createState() => _MessageHeaderViewState();
}

class _MessageHeaderViewState extends State<MessageHeaderView> {
  int unReadCount =0;

  @override
  void initState() {
    super.initState();
    unReadCount = widget.unReadCount;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom:8.0),
      child: GestureDetector(
        onTap: () async {
          // setState(() {
          // });
          unReadCount = 0;
          await Navigator.of(context).push(
            PageRouteBuilder(
              pageBuilder: (context, _, __) => MessageScreen(
                user: widget.user,
                otherUser: widget.otherUser,
              ),
              opaque: false
            ),
          );
          if(mounted){
            setState(() {
              
            });
          }
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Container(
              //   height: 80,
              //   width: 80,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(
              //       100
              //     ),
              //     border: Border.all(
              //       width: 2,
              //     ),
              //     image: DecorationImage(
              //       image: NetworkImage(widget.otherUser.profilePicUrl),
              //       fit: BoxFit.cover,
              //     )
              //   ),
              // ),

              CachedNetworkImage(
                imageUrl: widget.otherUser.profilePicUrl,
                imageBuilder: (context, imageProvider) => Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2,
                    ),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: imageProvider, 
                      fit: BoxFit.cover
                    ),
                  ),
                ),
                placeholder: (context, url) => Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>( AppData.thirdColor,))),
                errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image,color: AppData.secondaryColor,)),
              ),
              
              Text(
                widget.otherUser.name,
                style: TextStyle(
                  color: AppData.secondaryColor,
                  fontSize: 20
                ),
              ),
              unReadCount != 0?Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppData.secondaryColor,
                  borderRadius: BorderRadius.circular(3),
                ),
                child:Text(
                  unReadCount.toString(),
                  style: TextStyle(
                    color: AppData.primaryColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ):Container()
            ],
          ),
        ),
      ),
    );
  }
}