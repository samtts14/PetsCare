import 'package:petscare/Servicios/animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServiceAnimal{
  static final FirestoreServiceAnimal _firestoreService = FirestoreServiceAnimal._internal();
  Firestore _db= Firestore.instance;
  
  FirestoreServiceAnimal._internal(); 
  
  

  factory FirestoreServiceAnimal(){
    return _firestoreService;
  }

  
  Stream<List<Animal>>getAnimales(email){
    return _db
    .collection('pets').where("owner", isEqualTo: email).snapshots().map(
      (snapshot)=>snapshot.documents.map(
        (doc)=>Animal.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }
  Future<void> addAnimal(Animal animal){
    return _db.collection('pets').add(animal.toMap());
  }
  Future<void> deleteAnimal(String id){
    return _db.collection('pets').document(id).delete();
  }

  Future<void> deleteAnimalFromHistorial(mascota){
    return _db.collection('historial').where("mascota", isEqualTo: mascota).getDocuments().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.documents){
        ds.reference.delete();
    }}); 
  }

  Future<void> updateAnimal(Animal animal){
    return _db.collection('pets').document(animal.id).updateData(animal.toMap());
  }

  

}