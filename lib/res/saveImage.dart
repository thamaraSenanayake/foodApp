import 'package:flutter/material.dart';

class SaveImage extends ModalRoute<void> {
  final SaveImageListener listener;

  SaveImage({@required this.listener});

  @override
  Duration get transitionDuration => Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.8);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      ) {
    return Material(
      type: MaterialType.transparency,
      child: _buildOverlayContent(context),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(),
          Container(
            height: 221,
            width: MediaQuery.of(context).size.width,
            // color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Column(
                    children: [
                      GestureDetector(
                        onTap: (){
                          
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width-50),
                          child: Center(
                            child: Text(
                              'Open gallery',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft:Radius.circular(10),
                              topRight:Radius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Colors.blueGrey,
                      ),
                      GestureDetector(
                        onTap: (){
                          // _makePhoneCall(tel);
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 50,
                          width: (MediaQuery.of(context).size.width-50),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft:Radius.circular(10),
                              bottomRight:Radius.circular(10),
                            )
                          ),
                          child: Center(
                            child: Text(
                              'Open camera',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: (){
                      // logoutClickListener.logoutClick(LogoutOption.Yes);
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 50,
                      width: (MediaQuery.of(context).size.width-50),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(
                          10
                        )
                      ),
                      child: Center(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                    ),
                  )
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTransitions(
      BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      position: Tween(
            begin: Offset(0.0, 1.0),
            end: Offset(0.0, 0.0))
        .animate(animation),
        child:child,
      // child: ScaleTransition(
      //   scale: animation,
      //   child: child,
      // ),
    );
  }
}

enum ImageSelectType{
  Gallery,
  Camera
}
abstract class SaveImageListener{
  imageSelectType(ImageSelectType imageSelectType);
}