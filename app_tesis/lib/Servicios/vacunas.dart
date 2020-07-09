class Vacuna{
  final String name;
  
  final String id;
  
  final String fechaVeterinario;
  final String detalleVeterinario;

  Vacuna({this.name, this.id, this.fechaVeterinario, this.detalleVeterinario}); 

  Vacuna.fromMap(Map<String, dynamic> data, String id):
    name = data["name"],
    fechaVeterinario = data['Ultima visita al veterinario'],
    detalleVeterinario = data['Vacunas'],
    id=id;

    Map<String, dynamic> toMap(){
      return {
        "name" : name,
        "Ultima visita al veterinario" : fechaVeterinario,
        "Vacunas" : detalleVeterinario,
      };
    }
}