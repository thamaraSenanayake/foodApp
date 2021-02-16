import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
import 'package:food_app/database/databse.dart';
import 'package:food_app/model/user.dart';
import 'package:food_app/module/textbox.dart';

class EditDialog extends StatefulWidget {
  final EditType type;
  final User user;
  EditDialog({Key key,@required this.type,@required this.user,}) : super(key: key);

  @override
  _EditDialogState createState() => _EditDialogState();
}

class _EditDialogState extends State<EditDialog> {
  String _initText = "";
  String _error = "";
  String _title = "";
  TextInputType textInputType = TextInputType.text;

  _setData(){
    if(widget.type == EditType.Name ){
      _title = "Update name or business name";
      _initText = widget.user.name;
    }
    else if(widget.type == EditType.Address ){
      _title = "Update your address";
      _initText = widget.user.address;
    }
    else if(widget.type == EditType.Email ){
      _title = "Update your email";
      _initText = widget.user.email;
      textInputType = TextInputType.emailAddress;
    }
    else if(widget.type == EditType.Description ){
      _title = "Update your Description";
      _initText = widget.user.description;
      textInputType = TextInputType.multiline;
    }
  }

  @override
  void initState() {
    super.initState();
    _setData();
  }

  _saveData(){
    if(_initText.isNotEmpty){
      if(widget.type == EditType.Name ){
        widget.user.name = _initText;
      }
      else if(widget.type == EditType.Address ){
        widget.user.address = _initText;
      }
      else if(widget.type == EditType.Email ){
        widget.user.email = _initText;
      }
      else if(widget.type == EditType.Description ){
        widget.user.description = _initText;
      }

      Database().updateUser(widget.user);
    }else{
      setState(() {
        _error = "Required field";
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppData.isDarkMode? Colors.black.withOpacity(0.8):Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      content: Container(
        width: 260.0,
        height: 250.0,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: const Color(0xFFFFFF),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              
              // dialog centre
              Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      _title,
                      style: TextStyle(
                        color: AppData.secondaryColor,
                        fontSize: 18.0,
                      ),
                      // textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                    child: Text(
                      _error,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15
                      ),
                    ),
                  ),
                  TextBox(
                    textBoxKey: null, 
                    onChange: (val){
                      _initText = val;
                      setState(() {
                        _error = "";
                      });
                    }, 
                    errorText: _error,
                    shadowDisplay: false,
                    initText: _initText,
                    textInputType: textInputType,
                  )
                ],
              ),

              Row(
                mainAxisAlignment:  MainAxisAlignment.end,
                children: <Widget>[
                  // dialog button
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: GestureDetector(
                      onTap: () {
                        _saveData();
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Done',
                          style: TextStyle(
                            color: AppData.secondaryColor,
                            fontSize: 18.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),

                  // dialog button
                  Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          // color: const Color(0xFF33b17c),
                        ),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.grey,
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
      );
  }
}

abstract class NeedToSingInClickListener{
  needToSingInClick(int option);
}