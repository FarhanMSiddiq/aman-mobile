import 'package:flutter/material.dart';

void showMsgDialog(BuildContext context , String title , String description){
          showDialog(context: context,
                    builder: (BuildContext context){
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(top: 20
                                , bottom: 20
                            ),
                            margin: EdgeInsets.only(top: 45), 
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(color: Colors.black,offset: Offset(0,0.2),
                                blurRadius: 3
                                ),
                              ]
                            ),
                            child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("${title}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold))
                                  ),
                                  Container(
                                    margin:  EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                    child: Text("${description}", style: TextStyle(fontSize: 14))
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin : EdgeInsets.only(top:10),
                                    child: Wrap(
                                    spacing : 5,
                                    children:[
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
                                        ),
                                        onPressed: (){
                                          Navigator.of(context).pop();
                                        },
                                      child:  Text("Tutup",style: TextStyle(fontSize: 12,color:Colors.red))),
                                      ]
                                    )
                                  )
                                ],
                              ),
                            )
                        ],
                      )
                      );
              }
          );
        }