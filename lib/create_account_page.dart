import 'package:flutter/material.dart';

import 'login_page.dart';

class CreateAccountPage extends StatefulWidget {
 // const CreateAccountPage({Key? key}) : super(key: key);
  CreateAccountPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

      body: Center(
        child: Column(
          children: <Widget>[
            Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                )
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username/Email',
              ),
            ),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(title: widget.title)));
                },
                child: Text('Sign up!')
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => LoginPage(title: widget.title)));
              },
              child: const Text('Already have an account? Sign up here!'),
            ),
          ],
        ),
      ),
    );
  }
}
