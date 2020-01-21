import 'package:flutter/material.dart';


class Login extends StatefulWidget{
   @override
   _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login>{
  @override
  Widget build(BuildContext context){
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView( // para arreglar lo del bottom overflowed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 400,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: -30,
                    height: 350,
                    width: width,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/img5.jpg'),
                          fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    height: 350,
                    width: width + 20,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/img5.jpg'),
                          fit: BoxFit.fill
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //SizedBox(height: 40,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Login", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30),),
                  SizedBox(height: 30,),
                  Container(
                  
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(106, 135, 198, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )
                      ]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Colors.grey[200]
                            ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Usuario",
                              hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                        
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contraseña",
                              hintStyle: TextStyle(color: Colors.grey)
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        Center(child: Text("Olvidó la contraseña?", style: TextStyle(color: Color.fromRGBO(106, 135, 198, 1)),)),
                        SizedBox(height: 30,),
                        Container(
                          height: 40,
                          margin: EdgeInsets.symmetric(horizontal: 60),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(106, 135, 198, 1),
                          ),
                          child: Center(
                            child: Text("Login", style: TextStyle(color: Colors.white),),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Center(child: Text("Crear una cuenta", style: TextStyle(color: Color.fromRGBO(106, 135, 198, 0.6),),)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ), 
    );
  }
}