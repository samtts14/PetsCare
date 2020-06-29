import 'package:app_tesis/Servicios/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User{
  final _auth = FirebaseAuth.instance;
    dynamic user;
    String userEmail;
    String userPhoneNumber;
  

    getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    final email = user.email;
    return email;
    // Similarly we can get email as well
    //final uemail = user.email;
  
    //print(uemail);
  }
}
