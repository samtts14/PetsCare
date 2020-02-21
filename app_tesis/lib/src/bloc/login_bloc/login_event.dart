import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
abstract class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props => [];
}

// Cambio en el email
class EmailChanged extends LoginEvent{
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged {email: $email}';
}
//cambio en la contraseña
class PasswordChanged extends LoginEvent{
  final String password;

  const PasswordChanged({@required this.password});

  @override
  List<Object> get props => [password];

  @override
  String toString() => 'EmailChanged {email: $password}';
}
//enviado
class Submitted extends LoginEvent{
  final String email;
  final String password;

  const Submitted({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'Submitted{email: $email, password: $password}';
}
// login con Google
class LoginWithGooglePressed extends LoginEvent{}
//login con credenciales
class LoginWithCredentials extends LoginEvent{
  final String email;
  final String password;

  const LoginWithCredentials({@required this.email, @required this.password});
  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'Submitted{email: $email, password: $password}';
}
