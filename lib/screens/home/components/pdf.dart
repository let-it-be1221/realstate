import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdf extends StatelessWidget {
  Pdf({super.key, required this.path,required this.text});
  String path;
  String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(text),
        centerTitle: true,
      ),

      body: SfPdfViewer.asset(path),
    );
  }
}
