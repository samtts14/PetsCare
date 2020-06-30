import 'package:app_tesis/screen/home/citas/add_event_page.dart';
import 'package:app_tesis/screen/home/citas/event_page.dart';
import 'package:flutter/material.dart';

class TareasHomeP extends StatefulWidget {
  @override
  _TareasHomePState createState() => _TareasHomePState();
}

class _TareasHomePState extends State<TareasHomeP> {
  PageController _pageController = PageController();

  double currentPage = 0;

  @override
  Widget build(BuildContext context) {

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
            child: Text("28", 
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
              icon: Icon(Icons.help_outline),
              onPressed: (){},// enviar a pantalla de ayuda de la app
            ),
          ],)
      ),
    );
  }

  Widget _mainContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 60,),
        Padding(
          padding: const EdgeInsets.all(24.0),
        child: Text("Lunes", 
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
          EventPage(),
          
        ],)
        ),
      ],
    );
  }
}