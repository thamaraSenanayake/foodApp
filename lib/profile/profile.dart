import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/profileInfo/personalInformation.dart';

class Profile extends StatefulWidget {
  final User user;
  Profile({Key key,@required this.user}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        // color: Colors.blue,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            
            Padding(
              padding: const EdgeInsets.only(top:20.0),
              child: Container(
                width: _width-20,
                height: 200,
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: _width-40,
                      height: 80,
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
                              image: DecorationImage(
                                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeabWkXTrS3TpRsbQ3ugejErdv4lfff8FgPw&usqp=CAU'),
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                          Text(
                            "Nimal Perera",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) => PersonalInformation(
                                    user: widget.user,
                                  ),
                                  opaque: false
                                ),
                              );
                            },
                            child: Icon(
                              Icons.arrow_forward,
                              size: 35,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: _width-40,
                      height: 80,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                color: Colors.blue,
                                width: 3
                              )
                            ),
                            child: Center(
                              child: Text(
                                "My Upload",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3
                              )
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Following 10",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 3
                              )
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Followers 3",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom:10.0),
              child: Container(
                
                child: Column(
                  children: [
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.notifications,

                        ),
                        title: Text(
                          "Notifications",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.star,

                        ),
                        title: Text(
                          "My favorite",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.settings,

                        ),
                        title: Text(
                          "Settings",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    Container(
                      color: Colors.white,
                      child: ListTile(
                        leading: Icon(
                          Icons.support,

                        ),
                        title: Text(
                          "Support",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}