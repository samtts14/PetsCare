import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';

class GuiaNutricion extends StatefulWidget {
  @override
  _GuiaNutricionState createState() => _GuiaNutricionState();
}

class _GuiaNutricionState extends State<GuiaNutricion> {
String assetPDFPath = "";
String assetPdf = "";
  
 @override
  void initState() {
    super.initState();

     getFileFromAsset("assets/pdf/nutricion.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        print(assetPDFPath);
      });
    });

    getFileFromAsset("assets/avesNutricion.pdf").then((f) {
      setState(() {
        assetPdf = f.path;
        print(assetPdf);
      });
    });
  }
   Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/nutricion.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
      //throw Exception("Error opening asset file");
    }
  }

   Future<File> getFileFromAsset2(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/avesNutricion.pdf");

      File asetFile = await file.writeAsBytes(bytes);
      return asetFile;
    } catch (e) {
      throw Exception("Error opening file");
    }
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter PDF"),
        ),
        body: Center(
          child: Builder(
            builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      RaisedButton(
                      color: Colors.cyan,
                      child: Text(" Abrir"),
                      onPressed: () {
                        if (assetPDFPath != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(path: assetPDFPath)));
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.yellow,
                      child: Text("Aves"),
                      onPressed: (){
                        if (assetPdf != null){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context)=>
                            PdfViewPage(path: assetPdf,))
                           );
                          }
                        }
                      )
                  ],
            ),
          )
        )
      )
    );              
  }
}

class PdfViewPage extends StatefulWidget {
  final String path;

  const PdfViewPage({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageState createState() => _PdfViewPageState();
}

class _PdfViewPageState extends State<PdfViewPage> {
  bool pdfReady = false;
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Document"),
      ),
      // body: Stack(
      //   children: <Widget>[
      //     PDFView(
      //       filePath: widget.path,
      //       autoSpacing: true,
      //       enableSwipe: true,
      //       pageSnap: true,
      //       swipeHorizontal: true,
      //       nightMode: false,
      //       onError: (e) {
      //         print(e);
      //       },
              
      //       onPageError: (page, e) {},
      //     ),
      //   ],
      // ),
   
    );
  }
}