import 'package:flutter/material.dart';
import 'package:food_app/const.dart';
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
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                    'Please sign in to place your order',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                    // textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextBox(textBoxKey: null, onChange: null, errorText: "")
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
                      // widget.needToSingInClickListener.needToSingInClick(1);
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