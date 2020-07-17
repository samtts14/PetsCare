import 'package:PetsCare/screen/authenticate/register_form.dart';
import 'package:PetsCare/src/bloc/register_bloc/bloc.dart';
import 'package:PetsCare/src/bloc/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class SignUp extends StatelessWidget {
  final UserRepository _userRepository;

  SignUp({Key key, @required UserRepository userRepository})
    :assert(userRepository !=  null),
    _userRepository = userRepository,
    super(key :key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<RegisterBloc>(
          create: (context)=> RegisterBloc(userRepository: _userRepository),
          child:  RegisterForm(),
        ) ,),
    );
  }
}