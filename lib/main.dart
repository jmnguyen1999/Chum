import 'dart:async';

import 'package:chum/add_dialog.dart';
import 'package:chum/models/items/reminder.dart';
import 'package:chum/models/items/task.dart';
import 'package:chum/pages/bottom_navigation/home_page.dart';
import 'package:chum/sqLite/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'pages/bottom_navigation/add_page.dart';
import 'pages/bottom_navigation/expenses_page.dart';
import 'constants.dart' as Constants;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chum',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

//Purpose: SplashScreen to display
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
            ()=>Navigator.pushReplacement(context,
            MaterialPageRoute(builder:
                (context) =>
                HomePage(title: 'Chum',)
            )
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFD5F3FE),
              //Color(0xFF66D3FA),
              Color(0xFF3C99DC),
              Color(0xFF2565AE)
              //Color(0xFF2565AE),
            ],
          )
      ),
      child: Container(
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset('assets/app_logo.png', height:150.0, width:150.0)
        )
      ),
    );
  }
}

