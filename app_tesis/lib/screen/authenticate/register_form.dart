import 'package:app_tesis/src/bloc/UI/google_login_button.dart';
import 'package:app_tesis/src/bloc/UI/register_button.dart';
import 'package:app_tesis/src/bloc/register_bloc/register_event.dart';
import 'package:app_tesis/src/bloc/register_bloc/bloc.dart';
import 'package:app_tesis/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:app_tesis/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_tesis/animations/FadeAnimation.dart';


class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  RegisterBloc _registerBloc;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isRegisterButtonEnabled(RegisterState state){
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }
  @override
  void dispose() {
   _emailController.dispose();
   _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context,state){
        //si el estado es submitting
        if(state.isSubmitting){
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Registrando'),
                    CircularProgressIndicator()
                  ],
                ) ,)
            );
        }
        //si el estado es Success
        if(state.isSuccess){
          BlocProvider.of<AuthenticationBloc>(context)
            .add(LoggedIn());
          Navigator.of(context).pop();
        }
        //si el estado es failure
        if(state. isFailure){
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Registro fallido'),
                  Icon(Icons.error)
                ],
              ),
              backgroundColor: Colors.red,
              )
            
          );
        }
      },
        child: BlocBuilder<RegisterBloc, RegisterState>(
            builder: (context, state){
              return Scaffold(

      resizeToAvoidBottomPadding: false,
      body: Container(
        //padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.yellow[600],// color 1 parte arriba de login
              Colors.yellow[800],// color 2
              Colors.yellow[900]// color 3
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeAnimation(1, Text("Crear cuenta", style: TextStyle(color: Colors.black, fontSize: 40),)),
                  SizedBox(height: 10,),
                  FadeAnimation(1.3, Text(" Registrate con nosotros!", style: TextStyle(color: Colors.black, fontSize: 18),)),
                ],
              ),
            ),
            //SizedBox(height: 20,),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60,),
                    FadeAnimation(1.4, Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),// borde del box de pass y correo
                        boxShadow: [BoxShadow(
                          color: Colors.brown[100],// color de sombra detras del box de passwor y correo.
                          blurRadius: 20, // difuminacion de sombra
                          offset: Offset(0, 10)
                        )]
                      ),
                      child: Column(
                        children: <Widget>[
                          //Nombre de usuario
                           Container(
                            padding: EdgeInsets.all(10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                icon: Icon(Icons.people),
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
                            child: TextFormField(
                              controller: _emailController,//ingreso de correo de registro
                              decoration: InputDecoration(
                                icon: Icon(Icons.email),
                                hintText: "E-mail",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              autovalidate: true,
                              validator: (_){
                                return !state.isEmailValid? 'Email invalido' : null;
                              },
                            ),
                          ),
                          Container(//password
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey[200]))
                            ),
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                icon:  Icon(Icons.lock),
                                hintText: "Contraseña",
                                hintStyle: TextStyle(color: Colors.grey),
                                //border: InputBorder.none
                              ),
                               obscureText: true,
                               autocorrect: false,
                               autovalidate: true,
                               validator: (_){
                                 return !state.isPasswordValid ? 'Contraseña invalida' : null;
                               },
                            ),
                          ),
                          
                        ],
                      ),
                    )),
                    SizedBox(height: 40,),
                   // FadeAnimation(1.5, Text("Olvidaste la contraseña?", style: TextStyle(color: Colors.grey),)),
                   // SizedBox(height: 0,),
                    //SizedBox(height: 20,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                         //boton Sign Up
                        RegisterButton(
                          onPressed: isRegisterButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
                        ),
                      ],
                      ),
                    ),
                    Container(
                      child: Column(
                           crossAxisAlignment: CrossAxisAlignment.center,
                           children: <Widget>[
                             SizedBox(height: 20),
                              FadeAnimation(1.7, Text("Continuar con una red social.", style: TextStyle(color: Colors.grey),)),
                              SizedBox(height: 20),
                              //boton Google
                              GoogleLoginButton(),
                           ],
                      ),
                    ),    
                  ],
                ),
              ),
            )
          ],
        ),
      ),
              );
            }
        ) ,
      );
  }
  void _onEmailChanged(){
    _registerBloc.add(
      EmailChanged(email: _emailController.text)
    );
  }

  void _onPasswordChanged(){
    _registerBloc.add(
      PasswordChanged(password: _passwordController.text)
    );
  }

  void _onFormSubmitted(){
    _registerBloc.add(
      Submitted(
        email: _emailController.text,
        password: _passwordController.text
      )
    );
  }
}