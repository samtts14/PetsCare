import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({ Key key, VoidCallback onPressed})
  :_onPressed = onPressed,
  super(key : key);
  @override
  Widget build(BuildContext context) {
    var maxWidthChild = SizedBox(
            width: 90,
            height: 17,
            child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),textAlign: TextAlign.center),
            );
    return RaisedButton(
      child: maxWidthChild,
      shape: RoundedRectangleBorder(// bordes
            borderRadius: new BorderRadius.circular(50),
            //side: BorderSide(color: Colors.red)
           ),
            color: Colors.brown[500], 
           
            onPressed: _onPressed,
    );
  }
}