import 'package:chums/task_page.dart';
import 'package:flutter/material.dart';

import 'add_page.dart';
import 'home_page.dart';
import 'info_page.dart';
class ExpensesPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  ExpensesPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Color(0xFFDBF0E9),
        bottomNavigationBar: Container(
          height: 50,
          child: BottomAppBar(
              color: Color(0xFFC9E3DA),
              shape: const CircularNotchedRectangle(),
              child: Row(
                children: [
                  //1.) Home Button: HomePage
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomePage(title: widget.title)));
                        },
                        icon: Icon(Icons.home_filled)
                    ),
                  ),

                  //2.) Task Icon: TaskPage
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

                  //3.) Add Icon: Add Dialog page - TODO
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddPage(title: widget.title)));
                        },
                        icon: Icon(Icons.add_circle_outline)
                    ),
                  ),

                  //4.) Money Icon: ExpensesPage - TODO: fix overflow
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ExpensesPage(title: widget.title)));
                        },
                        icon: Icon(Icons.monetization_on_outlined)
                    ),
                  ),

                  //5.) Info Icon: InfoPage
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
                      color: Colors.white,
                      width: 400,
                      alignment: Alignment.center,
                      child: Text(
                          'Your Master List',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
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
                                    child: Text('Reminders:',
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
                                        color: Colors.white,
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
                                        child: Text('Regular Expenses to Buy:',
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
                                            color: Colors.white,
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
                                                Text('Unique Expenses to Buy:',
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
                                                    color: Colors.white,
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
                ])
        )
    );
  }
}
