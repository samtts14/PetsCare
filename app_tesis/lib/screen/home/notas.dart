import 'package:flutter/material.dart';
// import //Importar paquete de guardado

class TextEdit extends StatefulWidget {
  var ocrText;

  TextEdit(this.ocrText);
  @override
  _TextEditState createState() => new _TextEditState(this.ocrText);
 }
class _TextEditState extends State<TextEdit> {
  var ocrText; //Valor inicial
  _TextEditState(this.ocrText);
  String result = "";

  @override
  Widget build(BuildContext context) {
    var values = ocrText; //values es una variable auxiliar
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Comentarios"),
        actions: <Widget>[
         new IconButton(////////////////////////////////////// Buton Save
           icon: new Icon(Icons.save, color: Colors.white,),
           onPressed: () {

            // Navigator.push(
               // context,
                //MaterialPageRoute(
                 // builder: (context) => SaveText(storage:  TextStorage(), resultToSave: result,) //creo que solo hay que enviarle el texto por que ya tiene hasta un counter 
               // ),
             // );
           },
         ),
       ],
      ),
     
    body: new Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width, //Toma el tamaño del area asignada
      
      child: new Stack(
        children: <Widget>[
          TextFormField(
            decoration: new InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Escribe aqui'
            ),
            //initialValue: values, //esto es por si tienen un valor inicial
            textAlign: TextAlign.justify, //Alineacion del texto
            keyboardType: TextInputType.multiline, //La tecla RETORNO o ENTER sirve paea hacer saltos de linea
            maxLines: null, //numero maximo de lineas si es nulo tomara lineas infinitas
            
            onChanged: (String value){ //Altera el valor o estado [ setState(() {}) ] de la variable final en tiempo real
              setState(() {
                result = value;// result almasena todo el texto
              });
            },
          ),
          
        ]  
      ),
    ),
   );
  }
}
