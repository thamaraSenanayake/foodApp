import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage({Key key, @required this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _width = 0.0;
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Container(
            width: _width-20,
            height: 450,
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
                  child: Text(
                    "Title/Boiler",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500
                    ),
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
                  height: 60,
                  child:Row(
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
                       Expanded(
                         child: Container(
                           height: 60,
                           child: Align(
                             alignment: Alignment.bottomCenter,
                             child: Text(
                              "Description https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800
                              ),
                      ),
                           ),
                         ),
                       ),
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.star,
                          size: 35,
                          color: Colors.yellow,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.message,
                          size: 35,
                          color: Colors.blue,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.call,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.location_on,
                          size: 35,
                          color: Colors.red,
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(
                          Icons.more_vert,
                          size: 35,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  )
                )
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}