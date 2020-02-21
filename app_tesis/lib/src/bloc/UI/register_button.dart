import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({ Key key, VoidCallback onPressed})
  :_onPressed = onPressed,
  super(key : key);
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(// bordes
            borderRadius: new BorderRadius.circular(50),
            //side: BorderSide(color: Colors.red)
           ),
            color: Colors.brown[500], 
            child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
            onPressed: _onPressed,
    );
  }
}