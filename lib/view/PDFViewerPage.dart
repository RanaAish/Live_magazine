import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import'package:live/constants.dart';


class PDFViewerPage extends StatefulWidget {
  final File ?file;

  const PDFViewerPage({
    Key? key,
    @required this.file,
  }) : super(key: key);

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {

  PDFViewController ? controller;
  int pages = 0;
  int indexPage = 0;

  @override
  Widget build(BuildContext context) {
    final name = basename(widget.file!.path);
    final text = '${indexPage + 1} of $pages';

    return Scaffold(
        appBar: AppBar(
            backgroundColor:primarycolor ,
            title:Text(name)
        ),
        body:
        new RotationTransition(
            turns: new AlwaysStoppedAnimation(360 / 360),child:
        PDFView(
          filePath: widget.file!.path,
          swipeHorizontal: true,
          // file url
          onRender: (pages) => setState(() => this.pages = pages!),
          onViewCreated: (controller) =>
              setState(() => this.controller = controller),
          onPageChanged: (indexPage, _) =>
              setState(() => this.indexPage = indexPage!),
        )));
  }
}