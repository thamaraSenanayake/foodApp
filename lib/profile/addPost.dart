import 'package:flutter/material.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/textbox.dart';
import 'package:intl/intl.dart';

class AddPost extends StatefulWidget {
  final User user;
  AddPost({Key key,@required this.user}) : super(key: key);

  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  double _width = 0.0;
  double _height = 0.0;
  int _radioValues = 1;
  DateTime intendDate = DateTime.now();

  _getDate() async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: intendDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != intendDate)
      setState(() {
        intendDate = picked;
      });
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
                onChange: null, 
                errorText: "",
                textBoxHint: "Title",
              ),

              SizedBox(
                height: 20,
              ),

              TextBox(
                textBoxKey: null, 
                onChange: null, 
                errorText: "",
                textBoxHint: "City",
              ),

              SizedBox(
                height: 20,
              ),

              TextBox(
                textBoxKey: null, 
                onChange: null, 
                errorText: "",
                textBoxHint: "Price",
              ),

              SizedBox(
                height: 20,
              ),

              TextBox(
                textBoxKey: null, 
                onChange: null, 
                errorText: "",
                textBoxHint: "Qty",
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
                        DateFormat.yMEd().format(intendDate),
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
                onChange: null, 
                errorText: "",
                textBoxHint: "Description",
                textInputType: TextInputType.multiline
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