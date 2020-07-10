class HistorialServ{
  final String titulo;
  final String descripcion;
  final String owner;
  final String fecha;
  final String mascota;
  final String id;

  HistorialServ({this.titulo, this.descripcion, this.id, this.fecha,this.owner, this.mascota}); 

  HistorialServ.fromMap(Map<String, dynamic> data, String id):
    titulo = data["titulo"],
    descripcion = data["descripcion"],
    owner = data["owner"],
    fecha = data["fecha"],
    mascota = data["mascota"],
    id=id;

    Map<String, dynamic> toMap(){
      return {
        "titulo" : titulo,
        "descripcion" : descripcion,
        "owner" : owner,
        "fecha" : fecha,
        "mascota" : mascota
      };
    }
}