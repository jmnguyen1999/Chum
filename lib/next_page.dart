import 'package:chums/third_page.dart';
import 'package:flutter/material.dart';

class MySecondPage extends StatefulWidget {
  MySecondPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MySecondPageState createState() => _MySecondPageState();
}

class _MySecondPageState extends State<MySecondPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
      print("The counter has been increased.");
    });

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyThirdPage())
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 300,
              height: 200,
              color: Colors.red,
              child: Image(
                  image: AssetImage('assets/logo.jpg')
              ),
            ),
            Container(
              width: 300,
              margin: EdgeInsets.only(bottom: 50, left: 20),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username'
                ),
              ),
            ),
            Text(
              'App Logo - Screen no 1',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.red
              ),
            ),
            Text(
              'My Demo app - screen no 1',
            ),
            Text(
              'Current Click: ${_counter*2}',
              style: Theme.of(context).textTheme.headline4,
            ),
            FlatButton(
                onPressed: (){},
                child: Text(
                  'Confirm'
                )
            ),
            RaisedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyThirdPage())
                );
              },
              child: Text('Confirm 2'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}