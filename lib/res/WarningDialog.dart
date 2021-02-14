import 'package:flutter/material.dart';

import '../const.dart';

class WarningDialog extends StatefulWidget {
  final WarningDialogClickListener listener;
  final String msg;
  WarningDialog({Key key,@required this.listener,@required this.msg,}) : super(key: key);

  @override
  _WarningDialogState createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> {
  
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding:EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      content: Container(
        width: 260.0,
        height: 180.0,
        padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color:  AppData.primaryColor,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            
            // dialog centre
            Row(
              children: [
                Text(
                  "Warning",
                  style: TextStyle(
                    color: AppData.thirdColor,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.warning,
                  color: AppData.thirdColor,
                )
              ],
            ),
            Text(
              widget.msg,
              style: TextStyle(
                color: AppData.secondaryColor,
                fontSize: 18.0,
              ),
            ),

            Row(
              mainAxisAlignment:  MainAxisAlignment.end,
              children: <Widget>[
                // dialog button
                Padding(
                  padding: const EdgeInsets.only(bottom:8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      widget.listener.clickYes();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Yes',
                        style: TextStyle(
                          color: AppData.thirdColor,
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
                        'No',
                        style: TextStyle(
                          color: AppData.secondaryColor,
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

abstract class WarningDialogClickListener{
  clickYes();
}