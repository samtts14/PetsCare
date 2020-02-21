class Validators{
  //Crear regExp
  //Email:
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9. !#$%´*+/=?^_´{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  //Password:
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=. *\d)[A-Za-z\d]{8,}',
  );
  //isValidEmail
  static isValidEmail(String email){
    return _emailRegExp.hasMatch(email);
  }
  //isValidPassword
  static isValidPassword(String password){

  }
}