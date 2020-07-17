import 'package:PetsCare/Servicios/historial_ser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  static final FirestoreService _firestoreService = FirestoreService._internal();
  Firestore _db= Firestore.instance;

  FirestoreService._internal(); 

  factory FirestoreService(){
    return _firestoreService;
  }
  Stream<List<HistorialServ>>getHistorial(mascota, email){
    return _db
    .collection('historial').where("mascota", isEqualTo: mascota).where('owner', isEqualTo: email).snapshots().map(
      (snapshot)=>snapshot.documents.map(
        (doc)=>HistorialServ.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }
  Future<void> addHistorial(HistorialServ historial){
    return _db.collection('historial').add(historial.toMap());
  }
  Future<void> deleteHistorial(String id){
    return _db.collection('historial').document(id).delete();
  }

  Future<void> updateHistorial(HistorialServ historial){
    return _db.collection('historial').document(historial.id).updateData(historial.toMap());
  }

}