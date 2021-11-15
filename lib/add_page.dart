import 'package:flutter/material.dart';
class AddPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  AddPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
