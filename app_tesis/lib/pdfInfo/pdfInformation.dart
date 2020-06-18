import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';


class PdfInfo extends StatefulWidget {
  @override
  _PdfInfoState createState() => _PdfInfoState();
}

class _PdfInfoState extends State<PdfInfo> {
  String assetPDFPath = "";
  

  @override
  void initState() {
    super.initState();

    getFileFromAsset("assets/pdf/avesNutricion.pdf").then((f) {
      setState(() {
        assetPDFPath = f.path;
        print(assetPDFPath);
      });
    });
  }

  Future<File> getFileFromAsset(String asset) async {
    try {
      var data = await rootBundle.load(asset);
      var bytes = data.buffer.asUint8List();
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/mypdf.pdf");

      File assetFile = await file.writeAsBytes(bytes);
      return assetFile;
    } catch (e) {
     // throw Exception("Error opening asset file");
    }
  }

  @override
  Widget build(BuildContext context) {
   
  }
}

class PdfViewPageInfo extends StatefulWidget {
  final String path;

  const PdfViewPageInfo({Key key, this.path}) : super(key: key);
  @override
  _PdfViewPageInfoState createState() => _PdfViewPageInfoState();
}

class _PdfViewPageInfoState extends State<PdfViewPageInfo> {
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.brown[600],
        title: Text("Información de la app"),
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
