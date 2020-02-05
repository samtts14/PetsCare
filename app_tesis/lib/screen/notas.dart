import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

 

class TextStorage {
  Future<String> get _internalPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _externelFile async {
    final path = await _internalPath;
    return File('$path/doc.txt');
  }

   Future<int> readText() async {
     try {
       final file = await _externelFile;

      // Leer archivo
       String contents = await file.readAsString();

       return int.parse(contents);
     } catch (e) {
       // Si encuentras un error, regresamos 0
       return 0;
     }
   }

  Future<File> writeText(int numero) async {
    final file = await _externelFile;

    // Escribir archivo
    return file.writeAsString('$numero');
  }
}

class SaveNote extends StatefulWidget {
  final TextStorage texto;
  SaveNote({Key key, @required this.texto}) : super(key: key);

  @override
  _SaveNote createState() => _SaveNote();
}
class _SaveNote extends State<SaveNote>{
  int cuenta;

  @override
  void initState(){
    super.initState();
    widget.texto.readText().then((int valor){
      setState((){
        cuenta = valor;
      });
    });
  }

  Future<File> _SumarN(){
    setState(() {
      cuenta++;
    });
    return widget.texto.writeText(cuenta);
  }

  //creo que ia Solo tengo que llamarlo? lles vamo a probal ajiaGracias amol de solanyi que hariamos sin ti, funciono? deja probal -_-

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("La emplosion")),
        body: Center(
          child: Text('cuenta vale $cuenta'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _SumarN,
          child: Icon(Icons.plus_one),
        ),
    );
  }
  
}
//--
class TextEdit extends StatefulWidget {
  var ocrText;

  TextEdit(this.ocrText);
  @override
  _TextEditState createState() => new _TextEditState(this.ocrText);
 }
class _TextEditState extends State<TextEdit> {
  var ocrText;
  _TextEditState(this.ocrText);
  String result = "";
  String ruta;

  @override
  void initState() {
    super.initState();
    result = ocrText;
    showRuta();
  }

  Future<void> showRuta() async{
    final directory = await getExternalStorageDirectory();
    
    setState(() {
      ruta = directory.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    var bodyText = ocrText;
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Edición"),
        actions: <Widget>[
         new IconButton(////////////////////////////////////// Buton Save
           icon: new Icon(Icons.save, color: Colors.white,),
           onPressed: () {

             Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RaisedButton(
                     onPressed: () async{
                                      
                    },
                  ),//botton de Guardar
                ),
              );
           },
         ),
       ],
      ),
     
    body: new Container(
      padding: const EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      
      child: new Stack(
        children: <Widget>[

          TextFormField(
            decoration: new InputDecoration.collapsed(
              border: InputBorder.none,
              hintText: 'Escribe aqui'
            ),
            initialValue: bodyText,
            textAlign: TextAlign.justify,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            
            onChanged: (String value){
              setState(() {
                result = value;
              });
            },
          ),
          
        ]  
      ),
    ),
   );
  }
}