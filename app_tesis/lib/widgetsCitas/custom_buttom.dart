import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {

  final VoidCallback onPressed;
  final String buttonText;
  final Color color;
  final Color textColor;
  final Color borderColor;

  CustomButtom({
    @required this.onPressed,
    @required this.buttonText,
    this.color,
    this.textColor,
    this.borderColor = Colors.transparent
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton( //boton Tarea
       onPressed: onPressed,
       shape: RoundedRectangleBorder(
         side: BorderSide(color: borderColor),
         borderRadius: BorderRadius.all(Radius.circular(12))
      ),
       color: color,
       textColor: textColor,
                //color: Theme.of(context).accentColor,  
       padding: const EdgeInsets.all(14.0),         
       child: Text(buttonText),
    );
  }
}