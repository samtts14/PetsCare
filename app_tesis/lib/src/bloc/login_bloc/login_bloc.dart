import 'package:PetsCare/src/bloc/login_bloc/bloc.dart';
import 'package:PetsCare/src/util/validators.dart';
import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:PetsCare/src/bloc/repository/user_repository.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState>{
  
  UserRepository _userRepository;
  //constructor
  LoginBloc({@required UserRepository userRepository})
  :assert (userRepository != null),
  _userRepository = userRepository;

  @override
  LoginState get initialState => LoginState.empty();

  @override
  Stream<LoginState> transformEvents(
    Stream<LoginEvent> events, Stream<LoginState> Function(LoginEvent) next) {
    final nonDebounceStream = events.where((event){
      return(event is! EmailChanged && event is! PasswordChanged);
      });
    final debounceStream = events.where((event){
      return (event is EmailChanged && event is PasswordChanged);
    }).debounceTime(Duration(microseconds: 300));

    return super.transformEvents(nonDebounceStream.mergeWith([debounceStream]), next);
  }

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async*{
    if(event is EmailChanged){
      yield* _mapEmailChangedToState(event.email);
    }
    if(event is PasswordChanged){
       yield* _mapPasswordChangedToState(event.password);
    }
    if(event is LoginWithGooglePressed){
      yield* _mapLoginWithGooglePressed();
    }
    if(event is LoginWithCredentials){
       yield* _mapLoginWithCredentials(
         email: event.email,
         password: event.password
       );
    }
  }

  Stream<LoginState> _mapEmailChangedToState(String email) async*{
    yield state.update(
      isEmailValid: Validators.isValidEmail(email)
    );
  }
  Stream<LoginState> _mapPasswordChangedToState(String password) async*{
    yield state.update(
      isEmailValid: Validators.isValidPassword(password)
    );
  }

  Stream<LoginState> _mapLoginWithGooglePressed()async*{
    try {
      await _userRepository.signInWithGoogle();
      yield LoginState.success();
      
    } catch (_) {
      yield LoginState.failure();
    }
  }
  Stream<LoginState> _mapLoginWithCredentials({
    String email, String password
  }) async*{
    yield LoginState.loading();
    try {
      await _userRepository.signInWithCredential(email, password);
      yield LoginState.success();//
      print(LoginState);
    } catch (_) {
     yield LoginState.failure();
    }

  }
}