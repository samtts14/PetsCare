import 'package:app_tesis/Servicios/note.dart';
import 'package:app_tesis/models/pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  // static final FirestoreService _firestoreService = FirestoreService._internal();
  Firestore _db= Firestore.instance;

  // FirestoreService._internal(); 
  final String uid;
  FirestoreService({ this.uid });

  final CollectionReference petsCollection = Firestore.instance.collection('pets');

  Future updatePetData(String name, String species, String breed, String sex, String age) async{
    return await petsCollection.document(uid).setData({
      'name': name,
      'species' : species,
      'breed' : breed,
      'sex' : sex,
      'age' : age,
    });
  }

  Future<void> addPet(Pet pet){
    return _db.collection('pets').add(pet.toMap());
  }

  
  // factory FirestoreService(){
  //   return _firestoreService;
  // }
  /// para manejo del uid

  /// para manejo de las notas
  Stream<List<Note>>getNotas(){
    return _db
    .collection('notes').snapshots().map(
      (snapshot)=>snapshot.documents.map(
        (doc){
          var documentID = doc.documentID;
          return Note.fromMap(doc.data, documentID);
        },
      ).toList(),
    );
  }
  Future<void> addNote(Note note){
    return _db.collection('notes').add(note.toMap());
  }
  Future<void> deleteNote(String id){
    return _db.collection('notes').document(id).delete();
  }

  Future<void> updateNote(Note note){
    return _db.collection('notes').document(note.id).updateData(note.toMap());
  }

}