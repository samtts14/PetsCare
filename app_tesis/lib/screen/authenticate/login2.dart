import 'package:petscare/src/bloc/login_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:petscare/src/bloc/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_form.dart';

class Login2 extends StatelessWidget {
  final UserRepository _userRepository;

  Login2({Key key, @required UserRepository userRepository})
    :assert(userRepository != null),
    _userRepository = userRepository,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: BlocProvider(
        create: (context) => LoginBloc(userRepository: _userRepository),
        child: LoginForm(userRepository: _userRepository),
        
      )
    );    
  }
}
