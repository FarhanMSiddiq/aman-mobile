import 'package:flutter/material.dart';


void showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: new EdgeInsets.only(top: 30,bottom:10),
            child: CircularProgressIndicator()
          ),
          Container(margin: EdgeInsets.only(bottom: 30),child:Text("Harap Menunggu..." )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }