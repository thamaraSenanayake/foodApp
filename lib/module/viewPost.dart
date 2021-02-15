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
  final Function updateUser;
  ViewPost({Key key,@required this.post,@required this.user, this.myPost = false,@required this.listener, this.canEdit = false, this.updateUser}) : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  double _width = 0;
  double _reviewPercentage = 0.0;
  bool _isFavorite = false;
  List<Widget> _imageList = [];
  bool _clapped = false;

  _call(String phone) async{
    
    var emailAddress = 'tel:'+phone;

    if(await canLaunch(emailAddress)) {
      await launch(emailAddress);
    }else{
      print("cant open dial");
    }   
  
  }

  _setData(){
    if(widget.user.favoritePost.contains(widget.post.id)){
      _isFavorite= true;
    }else{
      _isFavorite = false;
    }
    for (var item in widget.post.user.reviewList) {
      _reviewPercentage+= item.starCount;
    }if(widget.post.user.reviewList.length != 0){
      _reviewPercentage/=widget.post.user.reviewList.length;
    }else{
      _reviewPercentage = 0;
    }
    for (var item in widget.post.clapUser) {
      if(item.telNumber == widget.user.telNumber){
        _clapped = true;
        return;
      }
    }
  }

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      _imageListCreate();
    });
    _setData();
  }

  _imageListCreate(){
    List<Widget> imageList = [];
    for (var item in widget.post.imgUrl) {
      imageList.add(
        Container(
          height: 200,
          width: _width-40,
          child: Stack(
            children: [
              Container(
                height: 200,
                width: _width-40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: NetworkImage(item),
                    fit: BoxFit.cover,
                  )
                ),
              ),
              widget.post.imgUrl.length >1? Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${widget.post.imgUrl.indexOf(item)+1}/${widget.post.imgUrl.length}',
                    style: TextStyle(
                     color: AppData.secondaryColor,fontSize: 16,fontWeight: FontWeight.w500),
                  ),
                ),
              ):Container()
            ],
          ),
        )
      );
    }
    setState(() {
      _imageList = imageList;
    });
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
          color: AppData.primaryColor,
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
                     color: AppData.secondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w800
                    ),
                  ),
                  !widget.canEdit? GestureDetector(
                    onTap: (){
                      // List<String> favoritePost = widget.user.favoritePost;
                      Database().addRemoveFavorite(widget.post.id, widget.user);
                      if(widget.user.favoritePost.contains(widget.post.id)){
                        setState(() {
                          // widget.user.favoritePost = favoritePost;
                          _isFavorite = true;
                        });
                      }else{
                        setState(() {
                          // widget.user.favoritePost = favoritePost;
                          _isFavorite = false;
                        });
                      }
                      widget.listener.addToFavorite(widget.post.id);
                      print("_isFavorite"+_isFavorite.toString());
                    },
                    child: Icon(
                      _isFavorite?Icons.favorite:Icons.favorite_border,
                      color: AppData.thirdColor,
                    ),
                  ):Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          widget.listener.canEdit(widget.post);
                        },
                        child: Icon(
                          Icons.edit,
                          color: AppData.secondaryColor,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: (){
                          widget.listener.delete(widget.post);
                        },
                        child: Icon(
                          Icons.delete_forever,
                          color: AppData.thirdColor,
                          size: 25,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom:3.0),
              child: Text(
                widget.post.city,
                style: TextStyle(
                 color: AppData.secondaryColor,
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
                 color: AppData.secondaryColor,
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
                 color: AppData.secondaryColor,
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
                 color: AppData.secondaryColor,
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
                 color: AppData.secondaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),

            Container(
              height: 200,
              width: _width-20,
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: _imageList,
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            

            !widget.myPost? Container(
              height: 60,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      widget.listener.moveToProfile(widget.post.userTelNumber);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          widget.post.user.profilePicUrl.isNotEmpty? Container(
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
                          ):Container(
                            height: 60,
                            width: 60,
                            child: Center(
                              child: Text(
                                widget.user.name[0],
                                style: TextStyle(
                                //  color: AppData.secondaryColor,
                                  fontSize: 35,
                                  fontWeight: FontWeight.w800,
                                  color: AppData.primaryColor
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: AppData.secondaryColor,
                              borderRadius: BorderRadius.circular(100),
                            ),
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
                                     color: AppData.secondaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800
                                    ),
                                  ),
                                  widget.post.user.reviewList.length != 0? Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppData.thirdColor,
                                      ),
                                      Text(
                                        "$_reviewPercentage(${widget.post.user.reviewList.length})",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                         color: AppData.secondaryColor,
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
                  ),
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _clapped = true;
                      });
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
                        padding: const EdgeInsets.all(2.0),
                        child: Image.asset(
                          _clapped ? 'assets/icon/clapping.png':'assets/icon/unclapping.png',
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      widget.post.user.telNumber= widget.post.userTelNumber;
                      widget.listener.sendMessage(widget.post.user);
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
                        color: AppData.secondaryColor,
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
                        color: AppData.secondaryColor,
                      ),
                    ),
                  ),
                ],
              )
            ):Container()
            
          ],
        ),
      ),
    );
  }
}

abstract class ViewPostListener{
  moveToProfile(String userTelNumber);
  clap(String postId);
  sendMessage(User otherUser);
  takeCall(String userTelNumber);
  goToLocation(location);
  moreClick(String postId);
  canEdit(Post postId);
  delete(Post postId);
  addToFavorite(String postId);
}

//