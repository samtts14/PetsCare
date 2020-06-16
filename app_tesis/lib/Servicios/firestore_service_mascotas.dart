import 'package:app_tesis/Servicios/animal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  static final FirestoreService _firestoreService = FirestoreService._internal();
  Firestore _db= Firestore.instance;

  FirestoreService._internal(); 

  factory FirestoreService(){
    return _firestoreService;
  }
  Stream<List<Animal>>getAnimales(){
    return _db
    .collection('pets').snapshots().map(
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

  Future<void> updateAnimal(Animal animal){
    return _db.collection('pets').document(animal.id).updateData(animal.toMap());
  }

}