import 'package:flutter/material.dart';

SnackBar snackBar(String message,{callbackFunction,label = 'Undo'}) {
  return SnackBar(
    elevation: 0.0,
    backgroundColor: Colors.black.withOpacity(0.8),
    content: Text(
      '$message',
      style: TextStyle(
        fontSize: 18,
      ),
    ),
    action:callbackFunction ? SnackBarAction(
        label: '$label',
        textColor: Colors.green,
        onPressed: callbackFunction,
      ):null,
  );
}
