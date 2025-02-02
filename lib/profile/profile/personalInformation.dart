import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/const.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/profile/profile/editDialog.dart';
import 'package:food_app/profile/profile/multLine.dart';
import 'package:food_app/profile/profile/productListAdd.dart';
import 'package:food_app/res/saveImage.dart';
import 'package:image_picker/image_picker.dart';

class PersonalInformation extends StatefulWidget {
  final User user;
  PersonalInformation({Key key,@required this.user}) : super(key: key);

  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> implements SaveImageListener {
  double _width = 0.0;
  double _height = 0.0;
  File _image;
  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      resizeToAvoidBottomInset:false,
      body: Container(
        width : _width,
        height :_height,
        child: Stack(
          children: [
            Container(
              color: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
              width : _width,
              height :_height,
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
                                        color: AppData.secondaryColor
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
                                    fontWeight: FontWeight.w800,
                                    color: AppData.secondaryColor
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
                                    color: AppData.primaryColor,
                                    borderRadius: BorderRadius.circular(
                                      100
                                    ),
                                    border: Border.all(
                                      width: 2
                                    ),
                                    image:_image != null || widget.user.profilePicUrl.isNotEmpty?  DecorationImage(
                                      image:_image != null ? FileImage(_image): CachedNetworkImageProvider(widget.user.profilePicUrl),
                                      fit: BoxFit.cover,
                                    ):null
                                  ),
                                  child:_image == null && widget.user.profilePicUrl.isEmpty?
                                  Center(
                                    child: Text(
                                      widget.user.name[0],
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w800
                                      ),
                                    ),
                                  ):Container()
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
                                      color: AppData.primaryColor,
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
                                      Icons.add_a_photo,
                                      color: AppData.secondaryColor,
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
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) => EditDialog(
                                    type: EditType.Name,
                                    user: widget.user,
                                  ),
                                  opaque: false
                                ),
                              );
                            },
                            title: Text(
                              "Your name or business name",
                              style: TextStyle(
                                color:AppData.secondaryColor,
                                fontSize: 20
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color:AppData.secondaryColor,
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) => EditDialog(
                                    type: EditType.Address,
                                    user: widget.user,
                                  ),
                                  opaque: false
                                ),
                              );
                            },
                            title: Text(
                              "Permanent Address",
                              style: TextStyle(
                                color:AppData.secondaryColor,
                                fontSize: 20
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color:AppData.secondaryColor,
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) => EditDialog(
                                    type: EditType.Email,
                                    user: widget.user,
                                  ),
                                  opaque: false
                                ),
                              );
                            },
                            title: Text(
                              "Email",
                              style: TextStyle(
                                color:AppData.secondaryColor,
                                fontSize: 20
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color:AppData.secondaryColor,
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) => MultiLineDialog(
                                    type: EditType.Description,
                                    user: widget.user,
                                  ),
                                  opaque: false
                                ),
                              );
                            },
                            title: Text(
                              "Description",
                              style: TextStyle(
                                color:AppData.secondaryColor,
                                fontSize: 20
                              ),
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color:AppData.secondaryColor,
                            ),
                          ),
                        ),
                        Container(
                          child: ListTile(
                            onTap: (){
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder: (context, _, __) => ProductListAdd(
                                    user: widget.user,
                                  ),
                                  opaque: false
                                ),
                              );
                            },
                            title: Text(
                              "Your product or service list",
                              style: TextStyle(
                                color:AppData.secondaryColor,
                                fontSize: 20
                              )
                            ),
                            trailing: Icon(
                              Icons.arrow_forward,
                              color:AppData.secondaryColor,
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

            _loading?Container(
              color: Color.fromRGBO(128, 128, 128, 0.3),
              child: SpinKitDoubleBounce(
                color: AppData.thirdColor,
                size: 50.0,
              ),
            ):Container()
          ],
        ),
      ),
    );
  }

  Future<void> _uploadPic() async { 
    
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    FirebaseStorage _storage = FirebaseStorage.instance;

    print("upload pic");
    String imageName = new DateTime.now().millisecondsSinceEpoch.toString();
    
    for (var i = 0; i < 10; i++) {
      imageName += chars[rnd.nextInt(chars.length)];
    }

    // Create a reference to the location you want to upload to in firebase  
    StorageReference reference = _storage.ref().child(imageName);

    //Upload the file to firebase 
    StorageUploadTask uploadTask = reference.putFile(_image);
    var url = await (await uploadTask.onComplete).ref.getDownloadURL();

    widget.user.profilePicUrl = url;
    Database().updateUser(widget.user);
    if(mounted){
      setState(() {
        _loading = false;
      });  
    }
    
  }

  @override
  imageSelectType(ImageSelectType imageSelectType) async {
    PickedFile image;
    final picker = ImagePicker();

    if (imageSelectType == ImageSelectType.Camera) {
      image = await picker.getImage(source: ImageSource.camera);
    } else {
      image = await picker.getImage(source: ImageSource.gallery);
    }
    if(image != null){
      if(mounted){
        setState(() {
          _image = File(image.path);
          _loading = true;
        });
      }
      _uploadPic();
    }
  }
}