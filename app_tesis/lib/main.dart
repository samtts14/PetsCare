
import 'package:app_tesis/screen/authenticate/login2.dart';
import 'package:app_tesis/screen/home/Historial/add_historial.dart';
import 'package:app_tesis/screen/home/Historial/animales.dart';
import 'package:app_tesis/screen/home/citas/event_page.dart';
import 'package:app_tesis/screen/home/histo2.dart';
import 'package:app_tesis/screen/home/menu.dart';
import 'package:app_tesis/screen/home/notas.dart';
import 'package:app_tesis/src/bloc/UI/splash_screen.dart';
import 'package:app_tesis/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:app_tesis/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:app_tesis/src/bloc/authentication_bloc/authentication_state.dart';
import 'package:app_tesis/src/bloc/repository/user_repository.dart';
import 'package:app_tesis/src/bloc/simple_bloc_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';


void main(){
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate =  SimpleBlocDelegate();

  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create:(context)=> AuthenticationBloc(userRepository: userRepository) 
        ..add(AppStarted()),
      child: App(userRepository: userRepository),
    
    )
  );
}

class App extends StatelessWidget{
  final UserRepository _userRepository;
  App({Key key, @required UserRepository userRepository})
    :assert (userRepository != null),
    _userRepository = userRepository,
    super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: BlocBuilder< AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state is Uninitialized){
            return SplashScreen();
          }
          if (state is Authenticated){
            Mascotas(email: state.displayName);
            Notas(email: state.displayName);
            EventPage(email: state.displayName );
            Historial2(email: state.displayName);
            
            return MenuCentral(name: state.displayName,);
          }
          if(state is Unauthenticated){
            return Login2(userRepository: _userRepository,);
          }
          return Container();
        }
      )
    );
  }
}
