import 'package:app_tesis/animations/FadeAnimation.dart';
//import 'package:app_tesis/screen/menu.dart';
import 'package:flutter/material.dart';

class Login2 extends StatefulWidget{
   @override
   _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[900],// color 1 parte arriba de login
              Colors.orange[800],// color 2
              Colors.orange[400]// color 3
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text("Log in", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Bienvenido nuevamente!", style: TextStyle(color: Colors.white, fontSize: 18),)),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      FadeAnimation(1.4, Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),// borde del box de pass y correo
                          boxShadow: [BoxShadow(
                            color: Color.fromRGBO(225, 95, 27, .3),// color de sombra detras del box de passwor y correo.
                            blurRadius: 20, // difuminacion de sombra
                            offset: Offset(0, 10)
                          )]
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "E-mail.",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Colors.grey[200]))
                              ),
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: "Contraseña",
                                  hintStyle: TextStyle(color: Colors.grey),
                                  border: InputBorder.none
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                      SizedBox(height: 40,),
                      FadeAnimation(1.5, Text("Olvidaste la contraseña?", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 40,),
                      FadeAnimation(1.6, Container(
                        height: 50,
                        decoration: BoxDecoration( 
                        ),
                        width: 150,
                        child: RaisedButton( //Boton log in.
                           shape: RoundedRectangleBorder(// bordes
                          borderRadius: new BorderRadius.circular(50),
                          //side: BorderSide(color: Colors.red)
                          ),
                          color: Colors.orange[900], // color de boton de login
                          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          onPressed: () async{
                            //Boton log in
                          },
                        ),
                      )),
                      SizedBox(height: 50,),
                      FadeAnimation(1.7, Text("Continuar con una red social.", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeAnimation(1.8, Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.blue
                              ),
                              child: Center(
                                child: Text("Facebook", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            )),
                          ),
                          SizedBox(width: 30,),
                          Expanded(
                            child: FadeAnimation(1.9, Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.grey
                              ),
                              child: Center(
                                child: Text("Google", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                              ),
                            )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
