import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void showPdfDialog(BuildContext context , String pdf , String title){
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

    AlertDialog alert=AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                          margin: EdgeInsets.only(top: 20,bottom: 20),
                          child: Text("${title}",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF346D55)
                            ),
                          ),
          ),
          Container(
                          width: MediaQuery.of(context).size.width,
                          height: 600,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 66, 65, 65)
                          ),
                          child: SfPdfViewer.network(
                            pdf.replaceAll('aman-madrasah-staging', 'aman-madrasah'),
                            key: _pdfViewerKey,
                            canShowPaginationDialog :true),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: InkWell(
              onTap: (){
                  Navigator.of(context).pop();
              },
              child: Text("Tutup" ,
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          )
        ]),
    );
    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }