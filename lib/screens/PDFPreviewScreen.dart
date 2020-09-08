import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class PDFPreviewScreen extends StatefulWidget {
  static const String ROUTE_NAME = "PDFPreviewScreen";
  @override
  _PDFPreviewScreenState createState() => _PDFPreviewScreenState();
}

class _PDFPreviewScreenState extends State<PDFPreviewScreen> {
  PDFDocument doc;
  bool isLoading = false;

  void getPdfDocument() async{
    _changeLoading();
    String pdfUrl = ModalRoute.of(context).settings.arguments;
     doc = await PDFDocument.fromURL(pdfUrl);
     _changeLoading();
  }
  void _changeLoading(){
    setState(() {
      isLoading = !isLoading;
    });
  }
  @override
  void didChangeDependencies() {
    getPdfDocument();
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PDF Preview"),),
      body: Container(
        child: isLoading?CircularProgressIndicator():PDFViewer(document: doc,),
      ),
    );
  }
}
