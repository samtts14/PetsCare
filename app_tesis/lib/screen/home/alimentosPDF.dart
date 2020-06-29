import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

void main() => runApp(GuiaNutricion());

class GuiaNutricion extends StatefulWidget {
  @override
  _GuiaNutricionState createState() => _GuiaNutricionState();
}

class _GuiaNutricionState extends State<GuiaNutricion> {
  String perrosPDF = "";
  String gatosPDF = "";
  String avesPDF = "";

  @override
  void initState() {
    super.initState();

    getFileFromAsset("assets/pdf/avesNutricion.pdf").then((f) {
      setState(() {
        perrosPDF = f.path;
        print(perrosPDF);
      });
    });

    getFileFromAsset2("assets/pdf/nutricion.pdf").then((f) {
      setState(() {
        gatosPDF = f.path;
        print(gatosPDF);
      });
    });

    getFileFromAsset3("assets/pdf/gato.pdf").then((f){
      setState(() {
        avesPDF = f.path;
        print(avesPDF);
      });
    });
  }

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/perro.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
     // throw Exception("Error opening asset file");
    }
  }

  Future<File> getFileFromAsset2(String asset2) async {
   try {
      var data = await rootBundle.load(asset2);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/gato.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
     // throw Exception("Error opening asset file");
    }
  }
Future<File> getFileFromAsset3(String asset3) async{
  try{
    var data = await rootBundle.load(asset3);
    var bytes = data.buffer.asUint8List();
    var dir = await getApplicationDocumentsDirectory();
    File file = File("${dir.path}/ave");
    File assetFile = await file.writeAsBytes(bytes);
    return assetFile;
  }catch(e){}
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.brown[600],
          title: Text("Guia de nutrición de mascotas"),
        ),
        body: Center(
          child: Builder(
            builder: (context) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.yellow[800],
                      child: Text("Gatos", style: TextStyle(color: Colors.black, fontSize: 30)),
                      shape: RoundedRectangleBorder(// bordes
                        borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                      onPressed: () {
                        if (gatosPDF != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(path: gatosPDF)));
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.brown[500],
                      child: Text("Perros", style: TextStyle(color: Colors.white, fontSize: 30)),
                       shape: RoundedRectangleBorder(// bordes
                        borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                      onPressed: () {
                        if (perrosPDF != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(path: perrosPDF)));
                        }
                      },
                    ),
                     SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Colors.green[500],
                      child: Text("aves", style: TextStyle(color: Colors.black, fontSize: 30)),
                       shape: RoundedRectangleBorder(// bordes
                        borderRadius: new BorderRadius.circular(20),
                   // side: BorderSide(color: Colors.red)
                    ),
                      onPressed: () {
                        if (avesPDF != null) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PdfViewPage(path: avesPDF)));
                        }
                      },
                    ),
                  ],
                ),
          ),
        ),
      ),
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
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        title: Text("Guia de nutricón de mascotas"),
      ),
      body: Stack(
        children: <Widget>[
          PDFView(
            filePath: widget.path,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {
              print(e);
            },
            onRender: (_pages) {
              setState(() {
                _totalPages = _pages;
                pdfReady = true;
              });
            },
            onViewCreated: (PDFViewController vc) {
              _pdfViewController = vc;
            },
            onPageChanged: (int page, int total) {
              setState(() {});
            },
            onPageError: (page, e) {},
          ),
          !pdfReady
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Offstage()
        ],
      ),
     
    );
  }
}
