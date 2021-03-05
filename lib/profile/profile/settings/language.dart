import 'package:flutter/material.dart';
import 'package:food_app/module/customButton.dart';
import 'package:food_app/module/selectiveButton.dart';

import '../../../const.dart';


class Language extends StatefulWidget {
  Language({Key key,}) : super(key: key);

  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  double _width = 0.0;
  double _height = 0.0;
  int _selectVal = 1;

  @override
  void initState() {
    super.initState();
  }

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
        color: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
        child: SafeArea(
          child: Column(
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
                                  color: AppData.secondaryColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Chose Language",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppData.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectiveButton(text: "සිංහල", buttonClick: (){setState(() {
                      _selectVal =1;
                    });}, buttonValue: 1, selectValue: _selectVal,),
                    SizedBox(height:20),
                    SelectiveButton(text: "தமிழ்", buttonClick: (){setState(() {
                      _selectVal =2;
                    });}, buttonValue: 2, selectValue: _selectVal,),
                    SizedBox(height:20),
                    SelectiveButton(text: "English", buttonClick: (){setState(() {
                      _selectVal =3;
                    });}, buttonValue: 3, selectValue: _selectVal,)
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }

  
}