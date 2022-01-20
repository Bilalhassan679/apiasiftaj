import 'package:apiasiftaj/screens/ComplexModelExample.dart';
import 'package:apiasiftaj/screens/array_name_define_in_model.dart';
import 'package:apiasiftaj/screens/create_own_model_example.dart';
import 'package:apiasiftaj/screens/home_page.dart';
import 'package:apiasiftaj/screens/signup.dart';
import 'package:apiasiftaj/screens/upload_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UploadImageScreen(),
    );
  }
}
