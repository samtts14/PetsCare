import 'package:app_tesis/screen/home/citas/add_event_page.dart';
import 'package:app_tesis/screen/home/citas/add_task_page.dart';
import 'package:app_tesis/screen/home/citas/event_page.dart';
import 'package:app_tesis/screen/home/citas/task_page.dart';
import 'package:app_tesis/widgetsCitas/custom_buttom.dart';
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
                child: currentPage == 0 ? AddEventPage() : AddTaskPage(),
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
         child: _button(context),
        ),
        Expanded(child: PageView(
          controller: _pageController,
          children: <Widget>[//hace scroll de una ventana a otra
          EventPage(),
          TaskPage(),
        ],)),
      ],
    );
  }

 Widget _button(BuildContext context) {
    return Row(
          children: <Widget>[
            Expanded(
              child: CustomButtom(//cambio de color de botones
                onPressed: (){
                  _pageController.previousPage(
                    duration: Duration(milliseconds: 500), 
                    curve: Curves.bounceInOut
                  );
                }, 
                buttonText: "Citas",
                color: currentPage < 0.5 ? Colors.brown[500] : Colors.white,
                textColor: currentPage <0.5 ? Colors.white : Colors.brown[500], 
                 borderColor: currentPage <0.5 ?Colors.transparent : Colors.brown[600],
              )
              
            ),
              SizedBox(
                width:32
              ),
              Expanded(
              child: CustomButtom(
                onPressed: (){
                    _pageController.nextPage(
                    duration: Duration(milliseconds: 500), 
                    curve: Curves.bounceInOut
                  );
                }, 
                buttonText: "Tareas",
                color: currentPage > 0.5 ? Colors.brown[500] : Colors.white,
                textColor: currentPage > 0.5 ? Colors.white : Colors.brown[500], 
                 borderColor: currentPage > 0.5 ?Colors.transparent : Colors.brown[600],
                ),
        ),
      ]
    );
  }       
}