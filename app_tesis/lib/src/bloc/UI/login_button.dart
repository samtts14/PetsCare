import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
    :_onPressed = onPressed,
    super(key : key);

  @override
  Widget build(BuildContext context) {
   
var maxWidthChild = SizedBox(
            width: 90,
            height: 17,
            child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,),textAlign: TextAlign.center ),           
            );
    return RaisedButton( //Boton log in.
          child: maxWidthChild,
          shape: RoundedRectangleBorder(// bordes
          borderRadius: new BorderRadius.circular(50),
            //side: BorderSide(color: Colors.red)
          ),
          color: Colors.brown[500], // color de boton de login
          onPressed: _onPressed,
    );
  }
}