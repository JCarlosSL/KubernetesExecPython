import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:runpy/editor/bloc/run_bloc.dart';
import 'package:runpy/editor/view/editor_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RunBloc(),
      child: MaterialApp(
        title: 'RunPy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: const TextTheme(
            bodyText1: TextStyle(color: Colors.white),
            bodyText2: TextStyle(color: Colors.white),
            caption: TextStyle(color: Colors.white),
            subtitle1: TextStyle(color: Colors.white),
            headline1: TextStyle(color: Colors.white),
          )
        ),
        home: EditorPage(),
      ),
    );
  }
}
