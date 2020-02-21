import 'package:meta/meta.dart';

class RegisterState{
  final bool isEmailValid;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegisterState({@required this.isEmailValid,
  @required this.isPasswordValid,
  @required this.isSubmitting,
  @required this.isSuccess,
  @required this.isFailure
  });

  //ESTADOS

  //Vacio
  factory RegisterState.empty(){
  return RegisterState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isSuccess: false,
    isFailure: false
  );
}

  //Cargando
factory RegisterState.loading(){
  return RegisterState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: true,
    isSuccess: false,
    isFailure: false);
}
  //Failure
factory RegisterState.failure(){
  return RegisterState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isSuccess: false,
    isFailure: true);
}
  //Success
factory RegisterState.success(){
  return RegisterState(
    isEmailValid: true,
    isPasswordValid: true,
    isSubmitting: false,
    isSuccess: true,
    isFailure: false);
}
  //Update y Copywith

 RegisterState copyWith({
    final bool isEmailValid,
    final bool isPasswordValid,
    final bool isSubmitting,
    final bool isSuccess,
    final bool isFailure,
  }){
    return RegisterState(
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isSubmitting:  isSubmitting ?? this.isSubmitting,
      isSuccess:  isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure
    );
  }
  RegisterState update({
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
    return ''' RegisterState{
      isEmailValid: $isEmailValid,
      isPasswordValid: $isPasswordValid,
      isSubmitting: $isSubmitting,
      isSuccess: $isSuccess,
      isFailure: $isFailure
    }
    ''';
  }
  
}