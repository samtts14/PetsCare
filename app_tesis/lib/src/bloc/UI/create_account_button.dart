import 'package:PetsCare/screen/authenticate/sign_up.dart';
import 'package:PetsCare/src/bloc/repository/user_repository.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
    :assert(userRepository != null),
    _userRepository = userRepository,
    super(key:key);

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
        //side: BorderSide(color: Colors.brown[600])
        ),
        color: Colors.brown[500],
       
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