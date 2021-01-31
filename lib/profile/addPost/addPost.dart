import 'dart:io';
import 'dart:math';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/textbox.dart';
import 'package:food_app/profile/addPost/setLocation.dart';
import 'package:food_app/res/convert.dart';
import 'package:food_app/res/saveImage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../const.dart';
import '../homeBase.dart';

class AddPost extends StatefulWidget {
  final User user;
  final Post post;
  final HomeBaseListener listener;
  AddPost({Key key,@required this.user,@required this.post,@required this.listener}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> implements SaveImageListener {
  double _width = 0.0;
  double _height = 0.0;
  int _radioValues = 1;
  Post _post;
  
  String _titleError = '';
  String _cityError = '';
  String _priceError = '';
  String _amountError = '';
  String _descriptionError = '';
  String _imgUrlError = '';
  String _locationError = "";
  
  File _image;

  bool _loading = false;
  var chars = "abcdefghijklmnopqrstuvwxyz0123456789";

  


  _getDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: _post.intendDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != _post.intendDate)
      setState(() {
        _post.intendDate = picked;
      });
  }

  _save() async {
    FocusScope.of(context).unfocus();

    bool validation = true;

    if(_post.title.isEmpty){
      setState(() {
        _titleError ="Required field";
      });
      validation = false;
    }
    if(_post.city.isEmpty){
      setState(() {
        _cityError ="Required field";
      });
      validation = false;
    }
    // if(_post.price == 0){
    //   setState(() {
    //     _priceError ="Required field";
    //   });
    //   validation = false;
    // }
    if(_post.amount == 0){
      setState(() {
        _amountError ="Required field";
      });
      validation = false;
    }
    if(_post.description.isEmpty){
      setState(() {
        _descriptionError ="Required field";
      });
      validation = false;
    }
    if(_post.imgUrl.isEmpty && _image == null){
      setState(() {
        _imgUrlError ="Required field";
      });
      validation = false;
    }

    if(validation == true){
      setState(() {
        _loading = true;
      });

      if(_image != null){
        _post.imgUrl = await _uploadPic();
      }

      Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);

      String postId = new DateTime.now().millisecondsSinceEpoch.toString();
    
      for (var i = 0; i < 10; i++) {
        postId += chars[rnd.nextInt(chars.length)];
      }

      _post.id = postId;

      await Database().addPost(_post);

      setState(() {
        _loading = false;
      });

      if(widget.listener != null){
        widget.listener.moveToPage(ProfilePage.Home);
      }else{
        Navigator.pop(context);
      }

    }

  }

  Future<String> _uploadPic() async { 
    
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

    print(url);
    //returns the download url 
    return url;
      
    
  }

  _initData(){
    _post = widget.post;
    if(_post.id == null){
      _post.imgUrl = "";
      _post.userTelNumber =widget.user.telNumber;
      _post.title ="";
      _post.place ="";
      _post.amount =0;
      _post.price =0;
      _post.city ="";
      _post.intendDate =DateTime.now();
      _post.description ="";
      _post.forSale =true;
      _post.location = null;
    }else{
      widget.post.imgUrl =_post.imgUrl;
      widget.post.userTelNumber =_post.userTelNumber;
      widget.post.title =_post.title;
      widget.post.place =_post.place;
      widget.post.amount =_post.amount;
      widget.post.price =_post.price;
      widget.post.city =_post.city;
      widget.post.intendDate =_post.intendDate;
      widget.post.description =_post.description;
      widget.post.forSale =_post.forSale;
      widget.post.location =_post.location;
    } 
    print(_post.intendDate);
  }

  @override
  void initState() {
    super.initState();
    _initData();
  }
  
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
      _height= MediaQuery.of(context).size.height;
    });
    return SafeArea(
      child: Container(
        child: Stack(
          children: [
            Container(
              width: _width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                      child: Text(
                        _imgUrlError,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                    _image == null && _post.imgUrl.isEmpty? GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(SaveImage(listener:this));
                      },
                      child: Container(
                        width: _width - 40,
                        constraints: BoxConstraints(
                          minHeight: 50
                        ),
                        padding:EdgeInsets.only(
                          left:20,
                          right:20,
                        ),
                        decoration: BoxDecoration(
                          // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 3
                          ),
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
                            Text(
                              "Add Image",
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                            Icon(
                              Icons.add_a_photo,
                              color: Colors.grey
                            )
                            
                          ],
                        ),
                      ),
                    ):GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(SaveImage(listener:this));
                      },
                      child: Container(
                          height: 200,
                          width: _width-20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image:_image == null? 
                              NetworkImage('https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg'):
                              FileImage(_image),
                              fit: BoxFit.cover,
                            )
                          ),
                        ),
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    Container(
                      width: _width-40,
                      height: 50,
                      decoration: BoxDecoration(
                        // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 3
                        ),
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
                          Container(
                            width: (_width-46)/2,
                            // height: 50,
                            child: RadioListTile(
                              title:  Text(
                                'Sell',
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                              ),
                              value: 1,
                              groupValue: _radioValues,
                              onChanged: ( value) {
                                setState(() {
                                  _radioValues = value;
                                });
                              },
                            ),
                          ),
                          Container(
                            width: (_width-46)/2,
                            // height: 50,
                            child: RadioListTile(
                              title:  Text(
                                'Buy',
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                              ),
                              value: 2,
                              groupValue: _radioValues,
                              onChanged: ( value) {
                                setState(() {
                                  _radioValues = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),


                    SizedBox(
                      height: 20,
                      child: Text(
                        _titleError,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),

                    TextBox(
                      textBoxKey: null, 
                      onChange: (val){
                        _post.title = val;
                        setState(() {
                          _titleError = "";
                        });
                      }, 
                      errorText: _titleError,
                      textBoxHint: "Title",
                      initText: _post.title,
                    ),

                    SizedBox(
                      height: 20,
                      child: Text(
                        _cityError,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),

                    TextBox(
                      textBoxKey: null, 
                      onChange: (val){
                        _post.city = val;
                      }, 
                      errorText: _cityError,
                      textBoxHint: "City",
                      initText: _post.city,
                    ),

                    SizedBox(
                      height: 20,
                      child:Text(
                        _priceError,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),

                    TextBox(
                      textBoxKey: null, 
                      onChange: (val){
                        if(isNumeric(val)){
                          _post.price = double.parse(val);
                          setState(() {
                            _priceError = "";
                          });
                        }
                      },  
                      errorText: _priceError,
                      textBoxHint: "Price",
                      textInputType: TextInputType.number,
                      initText: _post.price != 0? _post.price.toString():"",
                    ),

                    SizedBox(
                      height: 20,
                      child:Text(
                        _amountError,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),

                    TextBox(
                      textBoxKey: null, 
                      onChange: (val){
                        if(isNumeric(val)){
                          _post.amount = int.parse(val);
                          setState(() {
                            _amountError = "";
                          });
                        }
                      },
                      errorText: _amountError,
                      textBoxHint: "Amount",
                      textInputType: TextInputType.number,
                      initText: _post.amount != 0? _post.amount.toString():"",
                    ),

                    SizedBox(
                      height: 20,
                    ),

                    GestureDetector(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        _getDate();
                      },
                      child: Container(
                        width: _width - 40,
                        constraints: BoxConstraints(
                          minHeight: 50
                        ),
                        padding:EdgeInsets.only(
                          left:20,
                          right:20,
                        ),
                        decoration: BoxDecoration(
                          // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 3
                          ),
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
                            Text(
                              "Intend Date",
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                            Text(
                              DateFormat.yMEd().format(_post.intendDate),
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                            Icon(
                              Icons.date_range,
                              color: Colors.grey
                            )
                            
                          ],
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 20,
                      child:Text(
                        _descriptionError,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),

                    TextBox(
                      textBoxKey: null, 
                      onChange: (val){
                        _post.description = val;
                      }, 
                      errorText: _descriptionError,
                      textBoxHint: "Description",
                      textInputType: TextInputType.multiline,
                      initText: _post.description,
                    ),

                    SizedBox(
                      height: 20,
                      child:Text(
                        _locationError,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        FocusScope.of(context).unfocus();
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context, _, __) => SetLocation(
                              user: widget.user, 
                              location: widget.post.location, 
                              setLocation: (location){
                                _post.location = location;
                              }
                            ),
                            opaque: false
                          ),
                        );
                      },
                      child: Container(
                        width: _width - 40,
                        constraints: BoxConstraints(
                          minHeight: 50
                        ),
                        padding:EdgeInsets.only(
                          left:20,
                          right:20,
                        ),
                        decoration: BoxDecoration(
                          // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                            width: 3
                          ),
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
                            Text(
                              "Set Location",
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                            Text(
                              _post.location != null? "Done":"",
                              style: TextStyle(
                                color: Colors.grey
                              ),
                            ),
                            Icon(
                              Icons.location_on,
                              color: Colors.grey
                            )
                            
                          ],
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                      text: "Save", 
                      buttonClick: (){
                        _save();
                      }
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    
                  ],
                ),
              ),      
            ),

            _loading?
            Container(
              width: _width,
              color:AppData.secondaryColor.withOpacity(0.8) ,
              child: SpinKitSquareCircle(
                color: AppData.secondaryColor,
                size: 50.0,
              ),
            ):Container(),
          ],
        ),
      )
    );
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
      setState(() {
        _imgUrlError = "";
        _image = File(image.path);
      });
    }
  }
}