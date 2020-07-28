import 'package:petscare/src/bloc/UI/google_login_button.dart';
import 'package:petscare/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:petscare/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:petscare/src/bloc/login_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:petscare/src/bloc/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petscare/animations/FadeAnimation.dart';
import 'package:petscare/src/bloc/UI/login_button.dart';
import 'package:petscare/src/bloc/UI/create_account_button.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository})
    :assert(userRepository != null),
    _userRepository = userRepository,
    super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
final TextEditingController _emailcontroller = TextEditingController();
final TextEditingController _passwordcontroller = TextEditingController();

LoginBloc _loginBloc;
UserRepository get _userRepository => widget._userRepository;
bool get isPopulated => 
  _emailcontroller.text.isNotEmpty && _passwordcontroller.text.isNotEmpty;

bool isButtonLoginEnable(LoginState state){
  return state.isFormValid && isPopulated && !state.isSubmitting;
}
  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of(context);
    _emailcontroller.addListener(_onEmailChanged);
    _passwordcontroller.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state){
        if(state.isFailure){
            Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(//mensaje de abajo
               SnackBar(
                 content: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children:[ Text('Fallo en inicio de sesion'), Icon(Icons.error)],
                 ),
                 backgroundColor: Colors.red,
              ),
            );
           
        }
        if(state.isSubmitting){
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
               SnackBar(
                 content: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children:[ Text('Iniciando sesion...'),
                   CircularProgressIndicator()],
                   
                 ),
              ),
            );
        }
        if(state.isSuccess){
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context,state){
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
                FadeAnimation(1, Text("Inicio de sesion", style: TextStyle(color: Colors.black, fontSize: 40),)),
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
                                controller: _emailcontroller,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.email),
                                  labelText: 'Email'
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autovalidate: true,
                                autocorrect: false,
                                validator: (_){
                                  return !state.isEmailValid? 'Email invalido' : null;
                                },
                              ),
                            Divider(),
                            TextFormField(
                                controller: _passwordcontroller,
                                decoration: InputDecoration(
                                  icon: Icon(Icons.lock),
                                  labelText: 'Contraseña'
                                ),
                                obscureText: true,
                                autovalidate: true,
                                autocorrect: false,
                                validator: (_){
                                  return !state.isPasswordValid? 'Contraseña invalida' : null;
                                },
                              ),
                          ],
                        ),
                      )),
                      //SizedBox(height: 40,),
                      //FadeAnimation(1.5, Text("Olvidaste la contraseña?", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 40,),
                      FadeAnimation(1.6, Container(
                        height: 50,
                        decoration: BoxDecoration( 
                        ),
                        width: 150,
                        child: Column(
                          children: <Widget>[
                            LoginButton(
                              onPressed: isButtonLoginEnable(state)
                                ? _onFormSubmitted
                                :null,
                            )//Boton de login por clase
                          ]),
                      )),
                      SizedBox(height: 30,),
                      FadeAnimation(1.7, Text("¿No tienes cuenta?", style: TextStyle(color: Colors.grey),)),
                      SizedBox(height: 15,),
                      Container(
                       child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: <Widget>[
                            //Boton de crear cuanta
                            CreateAccountButton(userRepository: _userRepository,),
                             SizedBox(height: 15,),
                            //Boton de login con googgle
                            GoogleLoginButton(),  
                         ]
                       ),
                      ),
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
      )
    );
  }
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    super.dispose();
  }

  void _onEmailChanged(){
    _loginBloc.add(
      EmailChanged(email: _emailcontroller.text)
    );
  }

   void _onPasswordChanged(){
    _loginBloc.add(
      PasswordChanged(password: _passwordcontroller.text)
    );
  }
  void _onFormSubmitted(){
    _loginBloc.add(
      LoginWithCredentials(
        email: _emailcontroller.text,
        password: _passwordcontroller.text
      )
    );
  }
}