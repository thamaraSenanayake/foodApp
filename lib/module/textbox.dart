import 'package:flutter/material.dart';

import '../const.dart';

class TextBox extends StatefulWidget {
  final String textBoxHint;
  final String initText;
  final IconData prefixIcon;
  final IconData suffixIcon;
  final String textBoxKey;
  final Function(String) onChange;
  final Function(String) onSubmit;
  final bool obscureText;
  final TextInputType textInputType;
  final bool firstLetterCapital;
  final TextEditingController textEditingController;
  final String errorText;
  final bool shadowDisplay;
  TextBox({
    Key key,
    @required this.textBoxKey,
    @required this.onChange,
    this.textBoxHint,
    this.prefixIcon,
    this.obscureText = false,
    this.textInputType = TextInputType.text,
    this.onSubmit,
    this.suffixIcon, 
    this.initText,
    this.firstLetterCapital = true, 
    this.textEditingController,
    @required this.errorText, 
    this.shadowDisplay = true,
  }) : super(key: key);

  @override
  _TextBoxState createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  double _width = 0.0;
  TextEditingController _controller;

  @override
  void initState() { 
    super.initState();
    if( widget.textEditingController == null){
      _controller = TextEditingController();
    }else{
      _controller = widget.textEditingController;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) { 
      if(widget.initText != null){
        _controller.text = widget.initText;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      _width = MediaQuery.of(context).size.width;
    });
    return Container(
      width: _width - 40,
      constraints: BoxConstraints(
        minHeight: widget.textInputType == TextInputType.multiline? 100:50
      ),
      padding:EdgeInsets.only(
        left:widget.prefixIcon == null ? 20 : 0,
        right:widget.suffixIcon == null? 20 : 0
      ),
      decoration: BoxDecoration(
        // color: widget.errorText.length ==0 ?Colors.white:Colors.redAccent,
        
        color: AppData.primaryColor,
        border: Border.all(
          color: widget.errorText.length ==0 ? !widget.shadowDisplay?AppData.secondaryColor:AppData.primaryColor:Colors.redAccent,
          width: 3
        ),
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(color: Color.fromRGBO(0, 0, 0, 0.25)),
          widget.shadowDisplay? BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 12.0,
            spreadRadius: 3.0,
            offset: Offset(
              1.0,
              1.0,
            ),
          ): BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.0),
            blurRadius: 12.0,
            spreadRadius: 3.0,
            offset: Offset(
              1.0,
              1.0,
            ),
          )
        ],
      ),
      child: TextField(
        style: TextStyle(
          color: AppData.secondaryColor, 
          fontSize: widget.prefixIcon == Icons.attach_money?18:15
        ),
        controller:_controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.textBoxHint,
          prefixIcon:widget.prefixIcon != null ? Icon(
            widget.prefixIcon,
            size: widget.prefixIcon == Icons.attach_money?21:24,
            color: Colors.black,
          ) : null,
          hintStyle:TextStyle(fontSize: 14, color: AppData.secondaryColor, height: 1.8),
          suffixIcon: widget.suffixIcon != null ? Icon(widget.suffixIcon) : null,
        ),
        maxLines: widget.textInputType == TextInputType.multiline?null:1,
        obscureText: widget.obscureText,
        keyboardType: widget.textInputType,
        textCapitalization: widget.firstLetterCapital?TextCapitalization.sentences:TextCapitalization.none,
        onChanged: (value) {
          widget.onChange(value);
        },
        onSubmitted: (value) {
          widget.onSubmit(value);
        },
      ),
    );
  }
}
