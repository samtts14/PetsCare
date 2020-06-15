class Animal{
  final String name;
  final String especie;
  final String sexo;
  final String raza;
  final String id;

  Animal({this.name, this.especie, this.id, this.sexo,this.raza}); 

  Animal.fromMap(Map<String, dynamic> data, String id):
    name = data["name"],
    especie = data["especie"],
    sexo = data["sexo"],
    raza= data["raza"],
    id=id;

    Map<String, dynamic> toMap(){
      return {
        "name" : name,
        "especie" : especie,
        "sexo" : sexo,
        "raza" : raza,
        
      };
    }
}