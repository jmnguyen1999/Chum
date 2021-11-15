
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class UserHomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  UserHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text(widget.title),
      ),*/
      backgroundColor: Color(0xFF3C99DC),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 175,
              height: 175,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: new BorderRadius.circular(30.0),
                  color: Colors.white
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Join a Circle?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),)
                ],
              ),
            ),

            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                labelText: 'Enter a Room Code',
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => HomePage(title: widget.title)));
                },
                child: Text('Your Circles')
            ),

          ],
        ),
      ),


    );
  }

}