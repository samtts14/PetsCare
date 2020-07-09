import 'package:app_tesis/pdfInfo/pdfInformation.dart';
import 'package:app_tesis/screen/home/Historial/animales.dart';
import 'package:app_tesis/screen/home/Historial/historial.dart';
import 'package:app_tesis/screen/home/alimentosPDF.dart';
import 'package:app_tesis/screen/home/citasHomeP.dart';
import 'package:app_tesis/screen/home/historial.dart';
import 'package:app_tesis/servicios/auth.dart';
import 'package:app_tesis/src/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:app_tesis/src/bloc/authentication_bloc/authentication_event.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:app_tesis/screen/home/notas.dart';
//import 'package:app_tesis/pdfInfo/pdfInformation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

// Menu principal
class MenuCentral extends StatefulWidget {
  final String name;
  MenuCentral({Key key, @required this.name}) : super(key:key);
  @override
  _MenuCentralState createState() => _MenuCentralState();
}

class _MenuCentralState extends State<MenuCentral>{
   String infoPDF = "";//string para pdfinfo 
   final AuthService _auth = AuthService();

  

  @override
  void initState() {
    super.initState();

    getFileFromAsset("assets/pdf/gato.pdf").then((f) {
      setState(() {
        infoPDF = f.path;
        print(infoPDF);
      });
    });
  }
  
  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/info.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
     // throw Exception("Error opening asset file");
    }
  }//parte de pdfinfo hasta aqui.

  
  Widget build(BuildContext context) {
    Mascotas(email: "${widget.name}");
    Widget  imgMovimiento = new Container(//imagenes en movimiento
    height: 200.0,
    child:  new Carousel(
      boxFit: BoxFit.cover,
      images: [
        AssetImage('images/perro.jpg'),
        AssetImage('images/gatos.jpg'),
        AssetImage('images/periquito.jpg'),
        
      ],
      autoplay: true,//mover img automatico o manual 
      animationCurve: Curves.fastOutSlowIn,
      animationDuration: Duration(seconds: 2),
      dotSize: 4.5,//tamano circulodebajo de imagenes
      indicatorBgPadding: 3,//tamano de franja debajo de las imagenes  
    ),
    
  );
    return Scaffold(
      
       appBar: new AppBar(
        backgroundColor: Colors.brown[600], //Color del bacground del titulo
        title:Text('Animal App') ,// Titulo de la app en el home page
        actions: <Widget>[
         // new IconButton(icon: Icon(Icons.search, color: Colors.black87,), onPressed: (){})//boton de buscar
        ],
      ),
//--
        drawer: new Drawer(//menu lateral
        child: new ListView(
          children: <Widget>[
           // imgMovimiento,
         
//header   
          new UserAccountsDrawerHeader(
            accountName: Text('nombre de usuario'),
            
            accountEmail: Text('${widget.name}'),
            currentAccountPicture: GestureDetector( // foto de perfil
              child: new CircleAvatar(
                backgroundColor: Colors.grey,
                child: Icon(Icons.person, color: Colors.black87),
              ),
            ),

            decoration: new BoxDecoration(//color menu lateral
              color: Colors.brown[600]
            ),
            ),   
            // Boddy
            InkWell(
              onTap: (){
                 Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context)=> MenuCentral(name:"nombre",)
                ));
              },//Boton home menu lateral
              child: ListTile(
                title: Text('Inicio'),
                leading: Icon(Icons.home),
              ),
            ),

             InkWell(
              onTap: (){},//Boton home menu lateral
              child: ListTile(
                title: Text('Mi cuenta'),
                leading: Icon(Icons.person),
              ),
            ),

             InkWell(
              onTap:() async{
               
                  
                Navigator.push(context, MaterialPageRoute(
                builder: (_) => Mascotas(email: widget.name,)));
              },//Boton home menu lateral
              child: ListTile(
                title: Text('Mis mascotas'),
                leading: Icon(Icons.pets),
              ),
            ),

             InkWell(
              onTap: (){
               Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context)=> TareasHomeP()
                ));
              },//Boton home menu lateral
              child: ListTile(
                title: Text('Mis citas'),
                leading: Icon(Icons.note),
              ),
            ),
            Divider(),

             InkWell(
              onTap: (){},//Boton home menu lateral
              child: ListTile(
                title: Text('Información'),
                leading: Icon(Icons.info, color: Colors.blue[300],),
              ),
            ),

            Divider(),
              
             InkWell(
              onTap: () async {
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
               // await _auth.signOut();
              },//Boton home menu lateral
              child: ListTile(
                title: Text('Cerrar sesión'),
                leading: Icon(Icons.power_settings_new, color: Colors.red[300],),
                
              ),
            ),
          ],
        ),
      ),
      
      body: Column(
        children: <Widget>[
          imgMovimiento,
          SizedBox(
            height: 20,
          ),
          new Expanded(
            child: GridView.count(         
            crossAxisSpacing: 10,// espacio vertical entre botones de menu
            crossAxisCount: 3, //numero de columnas del grid
            mainAxisSpacing: 10,// espacio horizontal entre botones de menu
            padding: const EdgeInsets.all(20), // separa los botones del borde de la pantalla.
            children: <Widget>[
                Container(
               child: RaisedButton.icon(
                    icon: Icon(Icons.pets, size: 70, color: Colors.grey[900]),
                    label: Text(""),
                    shape: RoundedRectangleBorder(// bordes
                    borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.grey[200],
                    onPressed: () async{  
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => Mascotas(email: widget.name)));            
                    },
                  ),
              ),
               Container(
               child: RaisedButton.icon(
                    icon: Icon(LineAwesomeIcons.apple,size: 70, color: Colors.red[800]),
                    label: Text(""),
                    shape: RoundedRectangleBorder(// bordes
                    borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.grey[200],
                    onPressed: () async{ 
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => GuiaNutricion()));              
                    },
                  ),
              ),
               Container(
               child: RaisedButton.icon(
                    icon: Icon(Icons.calendar_today, size: 70, color: Colors.blue[800]),
                    label: Text(""),
                    shape: RoundedRectangleBorder(// bordes
                    borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.grey[200],
                    onPressed: () async{ 
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => TareasHomeP(email:widget.name ,)));              
                    },
                  ),
              ),
              Container(
               child: RaisedButton.icon(
                    icon: Icon(Icons.note_add, size: 70, color: Colors.blueGrey[400],),
                    label: Text(""),
                    shape: RoundedRectangleBorder(// bordes
                    borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.grey[200],
                    onPressed: () async{ 
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => Notas(email: widget.name)));                            
                    },
                  ),
              ),
               Container(
               child: RaisedButton.icon(
                    icon: Icon(LineAwesomeIcons.plus_square, size: 70, color: Colors.red[800]),
                    label: Text(""),
                    shape: RoundedRectangleBorder(// bordes
                    borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.grey[200],
                    onPressed: () async{  
                       Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => HistorialVacuna(email: widget.name,)));              
                    },
                  ),
              ),
              Container(
                
               child: RaisedButton.icon(
                    icon: Icon(LineAwesomeIcons.info_circle, size: 70, color:Colors.lightGreen[800]),
                    label: Text(""),
                    shape: RoundedRectangleBorder(// bordes
                    borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.grey[200],
                    onPressed: () async{   
                       if (infoPDF != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPageInfo(path: infoPDF)));
                        }
                    },
                  ),
              ),
             ]
           ),
           
          ),
        ],
      )
    );
  }
}

