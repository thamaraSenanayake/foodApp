import 'package:flutter/material.dart';

import '../const.dart';

class HomeBase extends StatefulWidget {
  HomeBase({Key key}) : super(key: key);

  @override
  _HomeBaseState createState() => _HomeBaseState();
}

class _HomeBaseState extends State<HomeBase> {
  double _height;
  double _width;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _height = MediaQuery.of(context).size.height;
      _width = MediaQuery.of(context).size.width;
    });
    return Scaffold(
      body: Container(
        height:_height,
        width:_width,
        child: Stack(
          children: [
            
            Container(
              height:_height,
              width:_width,
              child: Image.asset(
                AppData.BACKGROUNDPATH,
                fit:BoxFit.cover
              ),
            ),

            Container(
              height:_height,
              width:_width,
              child:SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 70,
                      width: _width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:10),
                          GestureDetector(
                            onTap: (){

                            },
                            child: Container(
                              height: 70,
                              width: 70,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container()
                    ),
                    Container(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.white,
                            child: Icon(
                              Icons.home
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.white,
                            child: Icon(
                              Icons.menu
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.white,
                            child: Icon(
                              Icons.message
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            color: Colors.white,
                            child: Icon(
                              Icons.add
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ) ,
            ),
          ],
        ),
      ),
    );
  }
}