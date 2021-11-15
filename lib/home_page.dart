import 'package:chums/task_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'expenses_page.dart';
import 'info_page.dart';
class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
/*      appBar: AppBar(
        title: Text(widget.title),
      ),*/
        backgroundColor: Color(0xFFD5F3FE),
        bottomNavigationBar: Container(
          height: 50,
          child: BottomAppBar(
              color: Color(0xFFC9E3DA),
              shape: const CircularNotchedRectangle(),
              child: Row(
                children: [
                  Expanded(
                    child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.home_filled)
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => TaskPage(title: widget.title)));
                          }
                        },
                        icon: Icon(Icons.list_alt_outlined)
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: (){},
                        icon: Icon(Icons.add_circle_outline)
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => ExpensesPage(title: widget.title)));
                          },
                        icon: Icon(Icons.monetization_on_outlined)
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => InfoPage(title: widget.title)));
                          },
                        icon: Icon(Icons.info_outlined)
                    ),
                  ),
                ],
              )
          ),
        ),

      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 10,
                child: Container(
                  color: Color(0xFFC9E3DA),
                  width: 400,
                  alignment: Alignment.center,
                  child: Text(
                        'All Your Things',
                        style: TextStyle(
                            fontSize: 20,
                          /*color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                          decorationStyle: TextDecorationStyle.wavy,*/
                          fontFamily: 'RaleWay',
                        )

                      ),
                ),

            ),
            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.only(top: 5, bottom: 10),
                child: ElevatedButton(
                    onPressed: (){},
                    child: Text('See House Master List')
                ),
              ),
            ),

            //Announcements:
            Expanded(
              flex: 80,
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20),
                        child: Text('Announcements',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),

                      Container(
                        width: 350,
                        height: 130,
                        decoration: BoxDecoration(
                            color: Color(0xFFCDDEE8),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Container(
                                margin: EdgeInsets.only(left: 20, top: 15),
                                child: Text('- HW #2 for CS 4310 due on Friday 9/14'))),
                            Expanded(child: Container(
                                margin: EdgeInsets.only(left: 20, top: 10),
                                child: Text('- Martha\'s family visiting on Friday 9/14'))),
                            Expanded(child: Container(
                                margin: EdgeInsets.only(left: 20, top: 10, bottom: 15),
                                child: Text('- water filter broken, we need to find another'))),
                          ],
                        ),
                      ),
                    ]
                ),

                //Today section:
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(left: 20),
                        child: Text('Today, Friday 9/8:',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold
                            )
                        ),
                      ),

                      Container(
                        width: 350,
                        height: 130,
                        decoration: BoxDecoration(
                            color: Color(0xFFCDDEE8),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: Container(
                                margin: EdgeInsets.only(left: 20, top: 15),
                                child: Text('- Buy tissue paper by @11:59pm'))),
                            Expanded(child: Container(
                                margin: EdgeInsets.only(left: 20, top: 10),
                                child: Text('- Take out trash by @7pm'))),
                            Expanded(child: Container(
                                margin: EdgeInsets.only(left: 20, top: 10, bottom: 15),
                                child: Text('...'))),
                          ],
                        ),
                      ),


                          //Tomorrow section:
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Column(
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                margin: EdgeInsets.only(left: 20),
                                child:
                                  Text('Today, Wednesday 9/8:',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold
                                    )
                                  ),
                              ),

                          Container(
                            width: 350,
                            height: 130,
                            decoration: BoxDecoration(
                              color: Color(0xFFCDDEE8),
                              borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                              child:
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 15),
                                  child: Text('- Buy tissue paper by @11:59pm'))
                                ),

                                Expanded(child: Container(
                                  margin: EdgeInsets.only(left: 20, top: 10),
                                  child: Text('- Take out trash by @7pm'))
                                ),

                                Expanded(child: Container(
                                  margin: EdgeInsets.only(left: 20, top: 10, bottom: 15),
                                  child: Text('...'))
                                ),
                            ],
                            ),
                            ),
                    ]
                  ),
                )
            ]
          )
      )
    ]
    )
    )
     ]),
    )
    );
  }
}
