import 'package:chums/TestPage2.dart';
import 'package:flutter/material.dart';
class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children:[
          Expanded(
            flex: 40,
            child: Image(
              image: AssetImage('assets/logo.jpg'),
              fit: BoxFit.cover
            ),
          ),
          Expanded(
            flex: 50,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top:20, bottom: 20),
                  child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
                  child: TextField(
                    obscureText: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
                Text('Forgot Password',
                  style: TextStyle(
                    color: Colors.red
                  )
                ),
               Expanded(
                    child: Container(
                      margin: EdgeInsets.only(top: 40, bottom: 40),
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            )
                        ),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => TestPage2()));
                          },
                          child: Text('Login')
                      ),
                    ),
               ),
              ],
            ),
          ),
          Expanded(
            flex: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text('AppLogin')),
                IconButton(
                  onPressed: (){},
                    icon: Icon(Icons.book),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Icon(Icons.computer),
                )
              ],
            ),
          )
        ]
      )
    );
  }
}

