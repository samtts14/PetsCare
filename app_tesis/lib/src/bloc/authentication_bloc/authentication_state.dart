import 'package:app_tesis/src/bloc/authentication_bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/rendering.dart';

abstract class AuthenticationState extends Equatable{
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

// Estados de autenticacion:
// No inicializado --> splash screen
// Autenticado --> Home
// No autenticado --> Login

class Uninitialized extends AuthenticationState{
  @override
  String toString() => 'No inicializado';
}

class Authenticated extends AuthenticationState{
  final String displayName;

  const Authenticated(this.displayName);

  @override
  List<Object> get props => [displayName];

   @override
  String toString() => 'Autenticando - displayName :$displayName';
}

class Unauthenticated extends AuthenticationState{
  @override
  String toString() => 'No autenticado';
}