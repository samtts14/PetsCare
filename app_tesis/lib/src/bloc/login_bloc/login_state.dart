import 'package:petscare/src/bloc/login_bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

class LoginState{
  //variables definidas
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;


//Constructor
LoginState({@required this.isEmailValid, @required this.isPasswordValid,
@required this.isSubmitting, @required this.isSuccess, @required this.isFailure});
//Estados
//Vacio
factory LoginState.empty(){
  return LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isSuccess: false,
    isFailure: false
  );
}
//Cargando
factory LoginState.loading(){
  return LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: true,
    isSuccess: false,
    isFailure: false);
}
//Falla
factory LoginState.failure(){
  return LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isSuccess: false,
    isFailure: true);
}
//Exito
factory LoginState.success(){
  return LoginState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isSuccess: true,
    isFailure: false);
}
//Funciones adicionales: copy with - update
  LoginState copyWith({
    final bool isEmailValid,
    final bool isPasswordValid,
    final bool isSubmitting,
    final bool isSuccess,
    final bool isFailure,
  }){
    return LoginState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting:  isSubmitting ?? this.isSubmitting,
      isSuccess:  isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure
    );
  }
  LoginState update({
    bool isEmailValid,
    bool isPasswordValid
  }){
    return copyWith(
      isEmailValid: isEmailValid,
      isPasswordValid: isPasswordValid,
      isSubmitting: false,
      isFailure: false,
      isSuccess: false
    );
  }

  @override
  String toString() {
    return ''' LoginState{
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }
    ''';
  }
}