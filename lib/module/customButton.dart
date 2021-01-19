import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final Function buttonClick;
  CustomButton({Key key,@required this.text,@required this.buttonClick}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
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
          color: Colors.white,
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
        child:Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800
            ),
          ),
        ),
      ),
    );
  }
}