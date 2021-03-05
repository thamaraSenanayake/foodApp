import 'package:flutter/material.dart';
import 'package:food_app/const.dart';

class SelectiveButton extends StatefulWidget {
  final String text;
  final Function buttonClick;
  final buttonValue;
  final selectValue;
  SelectiveButton({Key key,@required this.text,@required this.buttonClick,@required this.buttonValue,@required this.selectValue}) : super(key: key);

  @override
  _SelectiveButtonState createState() => _SelectiveButtonState();
}

class _SelectiveButtonState extends State<SelectiveButton> {
  double _width = 0.0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return GestureDetector(
      onTap: (){
        widget.buttonClick();
      },
      child: Container(
        height: 50,
        width: _width-120,
        decoration: BoxDecoration(
          color: AppData.primaryColor,
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
        child:Stack(
          children: [
            Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  color: AppData.secondaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right:8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.check,
                  color: widget.buttonValue == widget.selectValue?AppData.secondaryColor:Colors.transparent,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}