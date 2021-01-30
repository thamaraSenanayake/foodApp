import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/res/saveImage.dart';

class PersonalInformation extends StatefulWidget {
  final User user;
  PersonalInformation({Key key,@required this.user}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> implements SaveImageListener {
  double _width = 0.0;
  double _height = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return Scaffold(
      body: Container(
        width : _width,
        height :_height,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image:AssetImage(
        //       AppData.BACKGROUNDPATH,
        //     ),
        //     fit: BoxFit.cover
        //   )
        // ),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              //header
              Column(
                children: [
                  Container(
                    width : _width,
                    height: 50,
                    // color: Colors.red,
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:10.0),
                          child: GestureDetector(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Profile Information",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: _width,
                    height: 150,
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                100
                              ),
                              border: Border.all(
                                width: 2
                              ),
                              image: DecorationImage(
                                image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTeabWkXTrS3TpRsbQ3ugejErdv4lfff8FgPw&usqp=CAU'),
                                fit: BoxFit.cover,
                              )
                            ),
                          ),
                        ),
                        Positioned(
                          left: (_width/2)+40,
                          top:100,
                          child:GestureDetector(
                            onTap: (){
                              Navigator.of(context).push(SaveImage(listener: this));
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
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
                              child: Icon(
                                Icons.add_a_photo
                              ),
                            ),
                          )
                        )
                      ],
                    ),
                  ),
                ],
              ),

              //image upload
              SizedBox(
                height: 100,
              ),

              Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Your name or business name",
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
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Permanent Address",
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
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Email",
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
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Description",
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
                  Container(
                    color: Colors.white,
                    child: ListTile(
                      title: Text(
                        "Your product or service list",
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

              Container()

            ],
          ),
        ),
      ),
    );
  }

  @override
  imageSelectType(ImageSelectType imageSelectType) {
    // TODO: implement imageSelectType
    throw UnimplementedError();
  }
}