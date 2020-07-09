class HistorialServ{
  final String titulo;
  final String descripcion;
  final String id;

  HistorialServ({this.titulo, this.descripcion, this.id}); 

  HistorialServ.fromMap(Map<String, dynamic> data, String id):
    titulo = data["titulo"],
    descripcion = data["descripcion"],
    id=id;

    Map<String, dynamic> toMap(){
      return {
        "titulo" : titulo,
        "descripcion" : descripcion,
      };
    }
}