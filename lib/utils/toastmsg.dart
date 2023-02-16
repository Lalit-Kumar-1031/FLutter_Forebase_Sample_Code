import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class toastmsg
{
  void Errortoast(String message)
  {
    Fluttertoast.showToast(msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
      textColor: Colors.white,
      backgroundColor: Colors.red,
      fontSize: 16
    );
  }
  void toast(String message)
  {
    Fluttertoast.showToast(msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        backgroundColor: Colors.green,
        fontSize: 16
    );
  }
}
