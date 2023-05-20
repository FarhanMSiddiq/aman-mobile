 import 'package:flutter/material.dart';

void snackBar(String msg , BuildContext context){
    final snackBar = SnackBar(
            content: Text(msg),
            action: SnackBarAction(
              label: 'Oke',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }