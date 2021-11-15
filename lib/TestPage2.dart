import 'package:flutter/material.dart';

class TestPage2 extends StatefulWidget {
  const TestPage2({Key? key}) : super(key: key);

  @override
  _TestPage2State createState() => _TestPage2State();
}

class _TestPage2State extends State<TestPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [

          Expanded(
            flex: 10,
            child: Row(
              children: [

                Expanded(
                  flex: 20,
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.menu),
                    color: Colors.red,
                  ),
                ),

                Expanded(
                  flex: 60,
                  child: Image(
                      image: AssetImage('assets/logo.jpg')
                  ),
                ),

                Expanded(
                  flex: 20,
                  child: IconButton(
                    onPressed: (){},
                    icon: Icon(Icons.chat),
                  ),
                )

              ],
            ),
          ),

          Expanded(
            flex: 65,
            child: Column(
              children: [
                Expanded(
                  flex: 70,
                  child: Image(
                    image: AssetImage('assets/logo.jpg'),
                    fit: BoxFit.cover
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    child: Row(
                      children: [
                        Text(
                          'Jimmy, 22',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Spacer(),
                        Text('8',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                            )
                        ),
                        Icon(
                          Icons.photo
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right:30),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.tag_faces,
                                size: 42
                              ),
                              Spacer(),
                              Container(
                                margin: EdgeInsets.only(right: 20),
                                child: Text('36',
                                    style: TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),

                        Expanded(
                          child: Row(
                            children: [
                              Icon(Icons.book,
                                  size: 42
                              ),
                              Spacer(),
                              Text('36',
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold
                                  )
                              ),
                            ],
                          ),
                        )
                      ]
                    ),
                  )
                ),

              ],
            ),
          ),

          Expanded(
            flex: 25,
            child: Row(
              children: [
                Text("Text")
              ],
            ),
          )
        ],
      )
    );
  }
}
