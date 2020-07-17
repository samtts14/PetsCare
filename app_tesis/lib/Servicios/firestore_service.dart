import 'package:PetsCare/Servicios/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  static final FirestoreService _firestoreService = FirestoreService._internal();
  Firestore _db= Firestore.instance;

  FirestoreService._internal(); 

  factory FirestoreService(){
    return _firestoreService;
  }
  Stream<List<Note>>getNotas(email){
    return _db
    .collection('note').where("owner", isEqualTo: email).snapshots().map(
      (snapshot)=>snapshot.documents.map(
        (doc)=>Note.fromMap(doc.data, doc.documentID),
      ).toList(),
    );
  }
  Future<void> addNote(Note note){
    return _db.collection('note').add(note.toMap());
  }
  Future<void> deleteNote(String id){
    return _db.collection('note').document(id).delete();
  }

  Future<void> updateNote(Note note){
    return _db.collection('note').document(note.id).updateData(note.toMap());
  }

}