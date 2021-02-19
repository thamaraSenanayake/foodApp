import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/textbox.dart';

class ProductListAdd extends StatefulWidget {
  final User user;
  ProductListAdd({Key key,@required this.user,}) : super(key: key);

  @override
  _ProductListAddState createState() => _ProductListAddState();
}

class _ProductListAddState extends State<ProductListAdd> {
  
  String _error ="";
  String _text = "";
  TextInputType textInputType = TextInputType.text;
  TextEditingController _controller;
  List<Widget> _productListWidget = [];

  _initWidget(){
    List<Widget> productListWidget = [];

    for (var item in widget.user.productList) {
      productListWidget.add(
        Padding(
          padding: const EdgeInsets.only(right:5.0),
          child: Chip(
            onDeleted: (){
              widget.user.productList.remove(item);
              _initWidget();
            },
            deleteIcon: Icon(
              Icons.close,
              color: Colors.red,
            ),
            label: Text(
              item,
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w800
              ),
            )
          ),
        )
      );
    }
    if(mounted){
      setState(() {
        _productListWidget = productListWidget;
      });
    }
  }

  _close(){
    Database().updateUser(widget.user);
  }

  _add(){
    if(_text.isNotEmpty){
      widget.user.productList.add(_text);
      _controller.text = "";
      _initWidget();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _initWidget();
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
      contentPadding:EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      content: Container(
        width: 260.0,
        height: 400.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: 260.0,
                height: 386.0,
                child: Column(
                    children: <Widget>[
                      
                      // dialog centre
                      Container(
                        child: Text(
                          "Add Product List",
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600
                          ),
                          // textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        height: 236,
                        width: 260.0,
                        // color: Colors.blue,
                        padding: EdgeInsets.symmetric(vertical:10),
                        child:SingleChildScrollView(
                          child: Wrap(
                            children: _productListWidget,
                          ),
                        ),
                      ),
                      TextBox(
                        textEditingController: _controller,
                        textBoxKey: null, 
                        onChange: (val){
                          _text = val;
                          setState(() {
                            _error = '';
                          });
                        }, 
                        errorText: _error,
                        shadowDisplay: false,
                        initText: "",
                        textInputType: textInputType,
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment:  MainAxisAlignment.end,
                        children: <Widget>[
                          // dialog button
                          Padding(
                            padding: const EdgeInsets.only(bottom:8.0),
                            child: GestureDetector(
                              onTap: () {
                                _add();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: AppData.secondaryColor,
                                ),
                                padding: EdgeInsets.all(10.0),
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    color: AppData.primaryColor,
                                    fontSize: 18.0,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),

                        ]
                      ),
                    ],
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:5.0,right: 5),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: (){
                    _close();
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppData.thirdColor,
                        width: 2
                      ),
                      shape: BoxShape.circle
                    ),
                    child: Icon(
                      Icons.close,
                      color: AppData.secondaryColor,
                      size: 25,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

abstract class NeedToSingInClickListener{
  needToSingInClick(int option);
}