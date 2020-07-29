//imports
import 'dart:async';
import 'package:petscare/Servicios/firestore_service_mascotas.dart';
import 'package:petscare/Servicios/animal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository{
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  String name = '';
  String especie = '';
  String raza = '';
  String edad = '';
  String sexo = '';
  String owner = '';

  //Constructor
  UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
    _googleSignIn = googleSignIn ?? GoogleSignIn();
  //SignInWithGoogle
  Future<FirebaseUser> signInWithGoogle() async{
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = 
      await googleUser.authentication;
    final AuthCredential credential = 
      GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken, 
      );

    await _firebaseAuth.signInWithCredential(credential);
    return _firebaseAuth.currentUser();
  }
  //signWithCredentials
  Future<void> signInWithCredential(String email, String password){
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }
  //Registro o SignUp
  Future<void> signUp(String email, String password) async{

    try{
      AuthResult result =await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password
      );
      FirebaseUser user = result.user;
      Animal animal =  Animal(
                        especie: "Especie",
                        name: "Nombre",
                        raza: "Raza",
                        sexo: "Sexo",
                        owner: user.email.toString(),
                        fecha: "Fecha"
                      );
                        await  FirestoreServiceAnimal().addAnimal(animal);
      
      return result;
    }catch(e){
      print(e.tosString());
      return null;
    }
  }
  //SignOut
  Future<void> signOut() async{
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut()
    ]);
  }
  //Esta logueado?
  Future<bool> isSignedIn() async{
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }
  //Obtener usuario
  Future<String> getUser() async{
   return (await _firebaseAuth.currentUser()).email;
  }
}