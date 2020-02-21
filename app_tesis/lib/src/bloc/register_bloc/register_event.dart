import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class RegisterEvent extends Equatable{
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

//Eventos

//Cambio de Email
  class EmailChanged extends RegisterEvent{
  final String email;

  EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged {email: $email}';
}
//cambio de contraseña
class PasswordChanged extends RegisterEvent{
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'EmailChanged {email: $password}';
}
//Crear cuenta
class Submitted extends RegisterEvent{
  final String email;
  final String password;

  const Submitted({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'Submitted{email: $email, password: $password}';
}