import 'package:flutter/material.dart';

/// Activate enviornment env/bin/activate
/// Run server source python manage.py runserver 

abstract class Global{
  static String url = 'http://127.0.0.1:8000/python';
  static Color primary = const Color(0xff2E3152);
}
