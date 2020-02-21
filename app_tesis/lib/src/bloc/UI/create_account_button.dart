import 'package:app_tesis/screen/authenticate/sign_up.dart';
import 'package:app_tesis/src/bloc/repository/user_repository.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
    :assert(userRepository != null),
    _userRepository = userRepository,
    super(key:key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(// bordes
        borderRadius: new BorderRadius.circular(50),
        //side: BorderSide(color: Colors.brown[600])
        ),
        color: Colors.brown[500],
        child: Text("Sign Up", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        onPressed: (){
         Navigator.of(context).push(
            //  Dirige a la pantalla de registro
           MaterialPageRoute(builder: (context) {
             return SignUp(userRepository: _userRepository,);
           })
         );
        },
       );
  }
}