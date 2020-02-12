import 'package:app_tesis/screen/home/calendario.dart';
import 'package:app_tesis/servicios/auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:provider/single_child_widget.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:app_tesis/screen/home/notas.dart';



// Menu principal
class MenuCentral extends StatefulWidget {
  @override
  _MenuCentralState createState() => _MenuCentralState();
}

class _MenuCentralState extends State<MenuCentral>{
   final AuthService _auth = AuthService();
   
  @override
  Widget build(BuildContext context) {
    Widget  imgMovimiento = new Container(//imagenes en movimiento
    height: 200.0,
    child:  new Carousel(
      boxFit: BoxFit.cover,
      images: [
       // AssetImage('images/img2.jpg'),
        AssetImage('images/img3.jpg'),
        //AssetImage('images/img4.jpg'),
        AssetImage('images/img5.jpg'),
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
          new IconButton(icon: Icon(Icons.search, color: Colors.black87,), onPressed: (){})//boton de buscar
        ],
      ),
//--
        drawer: new Drawer(//menu lateral
        child: new ListView(
          children: <Widget>[
           // imgMovimiento,
         
//header   
          new UserAccountsDrawerHeader(
            accountName: Text('Paquito'), 
            accountEmail: Text('paquito02@gmail.com'),
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
              onTap: (){},//Boton home menu lateral
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
              onTap: (){},//Boton home menu lateral
              child: ListTile(
                title: Text('Mis mascotas'),
                leading: Icon(Icons.pets),
              ),
            ),

             InkWell(
              onTap: (){},//Boton home menu lateral
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
                await _auth.signOut();
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
                    },
                  ),
              ),
               Container(
               child: RaisedButton.icon(
                    icon: Icon(Icons.note, color: Colors.brown[400]),
                    label: Text("este"),
                    shape: RoundedRectangleBorder(// bordes
                    borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.grey[200],
                    onPressed: () async{             
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
                        MaterialPageRoute(builder: (context) => Calendario()));              
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
                        MaterialPageRoute(builder: (context) => TextEdit("")));                            
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
                    },
                  ),
              ),
              Container(
               child: RaisedButton.icon(
                    icon: Icon(LineAwesomeIcons.map_marker, size: 70, color:Colors.lightGreen[800]),
                    label: Text(""),
                    shape: RoundedRectangleBorder(// bordes
                    borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                    color: Colors.grey[200],
                    onPressed: () async{             
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

