import 'package:app_tesis/animations/FadeAnimation.dart';
import 'package:app_tesis/screen/auth.dart';
import 'package:flutter/material.dart';


class SingUp extends StatefulWidget{
   @override
   _SingUpState createState() => new _SingUpState();
}

class _SingUpState extends State<SingUp> {

  final AuthService _auth = AuthService();
  //final _formKey = GlobalKey<FormState>();
  bool loading = false;
  
  // text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.orange[400],// color 1 parte arriba de login
              Colors.orange[800],// color 2
              Colors.orange[900]// color 3
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
                  FadeAnimation(1, Text("Sign up", style: TextStyle(color: Colors.white, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text("Registrate con nosotros!", style: TextStyle(color: Colors.white, fontSize: 18),)),
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
                  child: SingleChildScrollView(
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
                              //Nombre de usuario
                               Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Nombre de usuario",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                              // colocar e-mail
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "E-mail",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                  onChanged: (val) {
                                    setState(() => email = val);
                                  },
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: "Contraseña",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                  onChanged: (val) {
                                    setState(() => password = val);
                                  },
                                ),
                              ),
                                  //Comprobar contraseña
                               Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: "Confirmar Contraseña",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                        SizedBox(height: 40,),
                       // FadeAnimation(1.5, Text("Olvidaste la contraseña?", style: TextStyle(color: Colors.grey),)),
                        SizedBox(height: 0,),
                        FadeAnimation(1.6, Container(
                          height: 50,
                          decoration: BoxDecoration(
                          ),
                          width: 150,// tamaño del boton aceptar
                          child: RaisedButton(
                           shape: RoundedRectangleBorder(// bordes
                            borderRadius: new BorderRadius.circular(50),
                            //side: BorderSide(color: Colors.red)
                            ),
                            color: Colors.orange[900],//color del boton
                            child: Text("Aceptar ", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            onPressed: () async{//config boton sign in anon
                               dynamic result = await _auth.registerWithEmailAndPassword(email, password); 
                               if (result == null){
                                 print("Error al iniciar sesión");
                               } else{
                                 print("Sesión iniciada");
                                 print(result);
                               }
                            }
                          ),
                        )),
                        SizedBox(height: 20,),
                        FadeAnimation(1.7, Text("Continuar con una red social.", style: TextStyle(color: Colors.grey),)),
                        SizedBox(height: 20,),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: FadeAnimation(1.9, Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue
                                ),
                                width: 150,
                                child: RaisedButton(
                                   shape: RoundedRectangleBorder(// bordes
                                   borderRadius: new BorderRadius.circular(50),
                                   //side: BorderSide(color: Colors.red)
                                    ),
                                    color: Colors.orange[900],
                                    child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                    onPressed: () async{

                                  },
                                ),
                              )),
                            ),
                            SizedBox(width: 50,),
                            Expanded(
                              child: FadeAnimation(1.9, Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  
                                ),
                                width: 150,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(// bordes
                                  borderRadius: new BorderRadius.circular(50),
                                   //side: BorderSide(color: Colors.red)
                                    ),
                                  color: Colors.grey,
                                  child: Text("Google", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  onPressed: () async{
                                   
                                  },
                                ),
                              )),
                            )
                          ],
                        )
                      ],
                    ),
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

