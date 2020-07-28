import 'package:petscare/screen/home/citas/add_event_page.dart';
import 'package:petscare/screen/home/citas/event_page.dart';
import 'package:flutter/material.dart';

class TareasHomeP extends StatefulWidget {
  final String email;
  TareasHomeP({Key key, this.email}) : super(key:key);
  @override
  _TareasHomePState createState() => _TareasHomePState();
}

class _TareasHomePState extends State<TareasHomeP> {
  PageController _pageController = PageController();
  DateTime now = new DateTime.now();
  
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    
    
    DateTime date = new DateTime(now.year, now.month, now.day,);

    
    _pageController.addListener((){
      setState(() {
        currentPage = _pageController.page;
      });
    });

    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          height: 35,
          color: Colors.brown[600] //Color del numero en grande
        ),
        Positioned(
          right: 0,
            child: Text("${date.day}", 
              style: TextStyle(fontSize: 200, color: Color(0x10000000)),
          ),
        ),
        _mainContent(context),
      ],
    ),
      floatingActionButton: FloatingActionButton(//boton central de anadir
        onPressed: (){
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context){
              return Dialog(
                child: currentPage == 0 ? AddEventPage() : AddEventPage(), 
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))
              ),);
            }
          );
        },
        backgroundColor: Colors.brown[500],
        child: Icon(Icons.add)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.help_outline, color:  Colors.transparent,),
              onPressed: (){},// enviar a pantalla de ayuda de la app
            ),
          ],)
      ),
    );
  }

  String _getDay(dayOfTheWeek){
    String day = '';
    switch(dayOfTheWeek){
      case 1 : {day = "Lunes";} break;
      case 2 : {day = "Martes";} break;
      case 3 : {day = "Miercoles";} break;
      case 4 : {day = "Jueves";} break;
      case 5 : {day = "Viernes";} break;
      case 6 : {day = "Sabado";} break;
      case 7 : {day = "Domingo";} break;
    }
    return day;
  }

  Widget _mainContent(BuildContext context) {
    var dayOfWeek = 1;
    DateTime dayOfTheWeek = DateTime.now();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60,),
        Padding(
          padding: const EdgeInsets.all(24.0),
        child: Text("${_getDay(dayOfTheWeek.weekday) }", 
        style: TextStyle(
          fontSize:32, 
          fontWeight: FontWeight.bold),
        ),
    ),
       Padding(
         padding: const EdgeInsets.all(24.0),
        ),
        Expanded(child: PageView(
          controller: _pageController,
          children: <Widget>[//hace scroll de una ventana a otra
          EventPage(email: widget.email,),
          
        ],)
        ),
      ],
    );
  }
}