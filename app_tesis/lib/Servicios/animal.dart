class Animal{
  final String name;
  final String especie;
  final String sexo;
  final String raza;
  final String id;
  final String fecha;
  final String owner;
  final String fechaVeterinario;
  final String detalleVeterinario;

  Animal({this.name, this.especie, this.id, this.sexo,this.raza, this.fecha, this.owner, this.fechaVeterinario, this.detalleVeterinario}); 

  Animal.fromMap(Map<String, dynamic> data, String id):
    name = data["name"],
    especie = data["especie"],
    sexo = data["sexo"],
    raza= data["raza"],
    fecha = data['adquisicion'],
    owner = data['owner'],
    fechaVeterinario = data['Ultima visita al veterinario'],
    detalleVeterinario = data['Vacunas'],
    id=id;

    Map<String, dynamic> toMap(){
      return {
        "name" : name,
        "especie" : especie,
        "sexo" : sexo,
        "raza" : raza,
        "owner" : owner,
        "Adquisicion" : fecha,
        "Ultima visita al veterinario" : fechaVeterinario,
        "Vacunas" : detalleVeterinario,
      };
    }
}