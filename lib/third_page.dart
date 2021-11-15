import 'package:flutter/material.dart';

import 'TestPage.dart';

class MyThirdPage extends StatefulWidget {
  const MyThirdPage({Key? key}) : super(key: key);

  @override
  _MyThirdPageState createState() => _MyThirdPageState();
}

class _MyThirdPageState extends State<MyThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 25,
              child: Text('title 1'),
            ),
            Expanded(
              child: Text('title 2'),
              flex: 25,
            ),
            Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TestPage())
                          );
                        },
                        child: Text('Login')
                    ),
                    flex: 1,
                  ),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){},
                        child: Text('Signup')
                    ),
                    flex: 1,
                  )
                ]
            )
          ],
        )
      )
    );
  }
}
