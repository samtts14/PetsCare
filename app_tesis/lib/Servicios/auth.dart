//import 'package:flutter/material.dart';
import 'package:app_tesis/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';


class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // // create user obj based on FirebaseUser
  // User _userFromFirebaseUser(FirebaseUser user){
  //   return user != null ? User(uid: user.uid) : null;
  // }
  
  // // auth change user stream
  // Stream<User> get user{
  //   return _auth.onAuthStateChanged
  //   .map(_userFromFirebaseUser);
  // }
  // // Sign in anonimo
  // Future signInAnon() async{
  //   try{
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     return user;
  //   }catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // // Sign in correo y pass
  // Future sigInWithEmailAndPassword(String email, String password) async{
  //   try {
  //     AuthResult result = await _auth.signInWithEmailAndPassword(
  //       email: email, 
  //       password: password);
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // // Registro con correo y pass.
  // Future registerWithEmailAndPassword(String email, String password) async{
  //   try {
  //     AuthResult result = await _auth.createUserWithEmailAndPassword(
  //       email: email, 
  //       password: password);
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // Sign out
  // Future signOut() async{
  //   try {
  //     return await _auth.signOut();
  //   } catch(e){
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //sign in Google
  
  

}