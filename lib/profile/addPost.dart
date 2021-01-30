import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_app/model/post.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/textbox.dart';
import 'package:food_app/res/convert.dart';
import 'package:intl/intl.dart';

class AddPost extends StatefulWidget {
  final User user;
  final Post post;
  AddPost({Key key,@required this.user,@required this.post}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  double _width = 0.0;
  double _height = 0.0;
  int _radioValues = 1;
  bool _isNetworkImage = false;


  _getDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: widget.post.intendDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != widget.post.intendDate)
      setState(() {
        widget.post.intendDate = picked;
      });
  }

  _initData(){
    if(widget.post.id == null){
      widget.post.imgUrl = "";
      //widget.post.id ="";
      widget.post.userTelNumber =widget.user.telNumber;
      widget.post.title ="";
      widget.post.place ="";
      // widget.post.price =0.0;
      // widget.post.qty =0;
      widget.post.amount ="";
      widget.post.city ="";
      widget.post.intendDate =DateTime.now();
      // widget.post.insertTime ="";
      widget.post.description ="";
      widget.post.forSale =true;
    }else{
      _isNetworkImage = true;
    }
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
        width: _width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              widget.post.imgUrl.isEmpty? Container(
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
              ):Container(
                  height: 200,
                  width: _width-20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image:_isNetworkImage? 
                      NetworkImage('https://upload.wikimedia.org/wikipedia/commons/6/6d/Good_Food_Display_-_NCI_Visuals_Online.jpg'):
                      Image.file(null),
                      fit: BoxFit.cover,
                    )
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
              ),

              TextBox(
                textBoxKey: null, 
                onChange: (val){
                  widget.post.title = val;
                }, 
                errorText: "",
                textBoxHint: "Title",
                initText: widget.post.title,
              ),

              SizedBox(
                height: 20,
              ),

              TextBox(
                textBoxKey: null, 
                onChange: (val){
                  widget.post.city = val;
                }, 
                errorText: "",
                textBoxHint: "City",
                initText: widget.post.city,
              ),

              SizedBox(
                height: 20,
              ),

              TextBox(
                textBoxKey: null, 
                onChange: (val){
                  if(isNumeric(val)){
                    widget.post.price = double.parse(val);
                  }
                },  
                errorText: "",
                textBoxHint: "Price",
                textInputType: TextInputType.number,
                initText: widget.post.price != null? widget.post.price.toString():"",
              ),

              SizedBox(
                height: 20,
              ),

              TextBox(
                textBoxKey: null, 
                onChange: (val){
                  if(isNumeric(val)){
                    widget.post.qty = int.parse(val);
                  }
                },
                errorText: "",
                textBoxHint: "Qty",
                textInputType: TextInputType.number,
                initText: widget.post.qty!= null? widget.post.qty.toString():"",
              ),

              SizedBox(
                height: 20,
              ),

              GestureDetector(
                onTap: (){
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
                        DateFormat.yMEd().format(widget.post.intendDate),
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
              ),

              TextBox(
                textBoxKey: null, 
                onChange: (val){
                  widget.post.description = val;
                }, 
                errorText: "",
                textBoxHint: "Description",
                textInputType: TextInputType.multiline,
                initText: widget.post.description,
              ),

              SizedBox(
                height: 20,
              ),

              Container(
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
                    Icon(
                      Icons.location_on,
                      color: Colors.grey
                    )
                    
                  ],
                ),
              ),

              SizedBox(
                height: 20,
              ),
              
            ],
          ),
        ),      
      )
    );
  }
}