import 'package:petscare/Servicios/animal.dart';
import 'package:petscare/Servicios/vacunas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServiceHistorial{
  static final FirestoreServiceHistorial _firestoreService = FirestoreServiceHistorial._internal();
  Firestore _db= Firestore.instance;
  
  FirestoreServiceHistorial._internal(); 
  
  

  factory FirestoreServiceHistorial(){
    return _firestoreService;
  }

  
  Stream<List<Vacuna>>getVacunas(email){
    return _db
    .collection('historial').where("owner", isEqualTo: email).snapshots().map(
      (snapshot)=>snapshot.documents.map(
        (doc)=>Vacuna.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }
  Future<void> addVacuna(Vacuna vacuna){
    return _db.collection('historial').add(vacuna.toMap());
  }
  Future<void> deleteVacuna(String id){
    return _db.collection('historial').document(id).delete();
  }

  Future<void> updateVacuna(Vacuna vacuna){
    return _db.collection('historial').document(vacuna.id).updateData(vacuna.toMap());
  }

}