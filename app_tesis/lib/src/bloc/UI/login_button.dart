import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;

  LoginButton({Key key, VoidCallback onPressed})
    :_onPressed = onPressed,
    super(key : key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton( //Boton log in.
        shape: RoundedRectangleBorder(// bordes
          borderRadius: new BorderRadius.circular(50),
            //side: BorderSide(color: Colors.red)
          ),
          color: Colors.brown[500], // color de boton de login
          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          onPressed: _onPressed,
    );
  }
}