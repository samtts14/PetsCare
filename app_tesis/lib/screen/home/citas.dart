import 'package:app_tesis/pcitas/addCita.dart';
import 'package:app_tesis/pcitas/addTarea.dart';
import 'package:app_tesis/pcitas/eventos.dart';
import 'package:app_tesis/pcitas/tareas.dart';
import 'package:app_tesis/pcitas/widget/botonCustom.dart';
import 'package:flutter/material.dart';

class Cita extends StatefulWidget {
  @override
  _CitaState createState() => _CitaState();
}

class _CitaState extends State<Cita> {

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
      body:Stack(
        children:<Widget>[ 
          Container(
            height: 35,
            color: Theme.of(context).accentColor,
          ),
          Positioned(
            right: 0,
            child:  Text("6", style: TextStyle(fontSize:200, color: Color(0*1000000000)),
          ),
        ),      
        contenidoPrincipal(context), 
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context){
                return Dialog(
                  child: currentPage == 1 ? AddTarea() : AddCitas(),//presenta la pantalla de crear cita o tarea
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ));
            }
          );
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
              IconButton(
                icon: Icon(Icons.settings), 
                onPressed: () {},
              ),
               IconButton(
                icon: Icon(Icons.more_vert), 
                onPressed: () {},
              ),
          ],
        )
      ),
    );
  }

  Widget contenidoPrincipal(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox( height: 60,),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text("Lunes", style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(24),
          child: button(context),
        ),
       Expanded(
         child: PageView(
           controller: _pageController,
           children: <Widget>[
            EventosState(),
            Tareas()
        ],
       ))
      ],
    );
  }

  Widget button(BuildContext context) {
    return Row(
          children: <Widget>[
            Expanded(
              child: BotonCustom(
                onPressed: (){
                  _pageController.previousPage(duration: Duration(milliseconds:500), curve: Curves.bounceOut);
                },
                buttonText: "Citas",
                 color: currentPage <0.5 ? Theme.of(context).accentColor : Colors.white,// cambia el clore del boton citas o tareas dependiendo el que elijas
                 textColor: currentPage <0.5 ? Colors.white : Theme.of(context).accentColor,
                 borderColor: currentPage <0.5 ? Colors.transparent : Theme.of(context).accentColor,
              )
             
            ),
            SizedBox(width: 32),
             Expanded(
                child: BotonCustom(
                  onPressed: (){
                     _pageController.nextPage(duration: Duration(milliseconds:500), curve: Curves.bounceOut);
                  },
                  buttonText: "Tareas",
                  color: currentPage > 0.5 ? Theme.of(context).accentColor : Colors.white,// cambia el clore del boton citas o tareas dependiendo el que elijas
                  textColor: currentPage > 0.5 ? Colors.white : Theme.of(context).accentColor,
                  borderColor: currentPage > 0.5 ? Colors.transparent : Theme.of(context).accentColor,
              )
            ),
          ],
        );
  }
}