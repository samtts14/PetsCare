import 'package:app_tesis/animations/FadeAnimation.dart';
import 'package:app_tesis/screen/auth.dart';
import 'package:app_tesis/screen/authenticate/sign_up.dart';
import 'package:app_tesis/shared/constant.dart';
//import 'package:app_tesis/screen/menu.dart';
import 'package:flutter/material.dart';

class Login2 extends StatefulWidget{
   
   final Function toggleView;
  Login2({this.toggleView});

   @override
   _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login2> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  
  String email = '';
  String password = '';
  String password1 = '';
  String error = '';
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.yellow[800],// color 1 parte arriba de login
              Colors.yellow[600],// color 2
              Colors.yellow[200]// color 3
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(1, Text("Log in", style: TextStyle(color: Colors.black, fontSize: 40),)),
                SizedBox(height: 10,),
                FadeAnimation(1.3, Text("Bienvenido nuevamente!", style: TextStyle(color: Colors.black, fontSize: 18),)),
              ],
            ),
            SizedBox(height: 20,),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 60,),
                      FadeAnimation(1.4, Container(
                        width: MediaQuery.of(context).size.width,
                        
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),// borde del box de pass y correo
                          boxShadow: [BoxShadow(
                            color: Colors.brown[100],// color de sombra detras del box de passwor y correo.
                            blurRadius: 10, // difuminacion de sombra
                            offset: Offset(15, 5)
                          )]
                        ),
                        child: Column(
                          children: <Widget>[
                              TextFormField(
                                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                                
                                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                                onChanged: (val) {
                                  setState(() => email = val);
                                },
                              ),
                            Divider(),
                            TextFormField(
                                decoration: textInputDecoration.copyWith(hintText: 'Contrasena'),
                                obscureText: true,
                                validator: (val) => val.length < 6 ? 'Contrasena tiene que ser mas de 6+ char' : null,
                                onChanged: (val) {
                                  setState(() => password = val);
                                },
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
                          color: Colors.brown[500], // color de boton de login
                          child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          onPressed: () async{
                            if(_formKey.currentState.validate()){
                              setState(() => loading = true);
                              dynamic result = await _auth.sigInWithEmailAndPassword(email, password);
                              if(result == null){

                                setState(() { 
                                  error = 'Could not sing in';
                                  loading = false;
                                  });
                              } else{
                                print('ecito');
                              }
                            }
                            
                            //Boton log in
                          },
                        ),
                      )),
                      SizedBox(height: 50,),
                      FadeAnimation(1.7, Text("No tienes cuenta?", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 30,),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: FadeAnimation(1.9, Container(
                              height: 50,
                              decoration: BoxDecoration(
                              ),
                              width: 150,
                              child: RaisedButton(
                                 shape: RoundedRectangleBorder(// bordes
                                 borderRadius: new BorderRadius.circular(50),
                                 //side: BorderSide(color: Colors.brown[600])
                                  ),
                                  color: Colors.brown[500],
                                  child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  onPressed: (){
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context) => SingUp()));
                                },
                              ),
                            )),
                          ),
                          SizedBox(width: 50,),
                          Expanded(
                            child: FadeAnimation(1.9, Container(
                              height: 50,
                              decoration: BoxDecoration(
                              ),
                              width: 150,
                                child: RaisedButton(
                                shape: RoundedRectangleBorder(// bordes
                                 borderRadius: new BorderRadius.circular(50),
                                 //side: BorderSide(color: Colors.brown[600])
                                  ),
                                color: Colors.grey[400],
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
            )
          ],
        ),
      ),
    );
  }
}
