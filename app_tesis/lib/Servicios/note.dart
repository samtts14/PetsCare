import 'package:app_tesis/models/user.dart';

class Note{
  final String title;
  final String description;
  final String id;
  //String usuario;

  Note({this.title, this.description, this.id}); 

  Note.fromMap(Map<String, dynamic> data, String id):
    title = data["title"],
    description = data["description"],
    id= id;
    // usuario = usuario;    
    

    Map<String, dynamic> toMap(){
      return {
        "title" : title,
        "description" : description,
        //"uid" : usuario,
        
      };
    }
}