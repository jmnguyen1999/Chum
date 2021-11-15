import 'package:flutter/material.dart';
class InfoPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  InfoPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
    );
  }
}
