import 'package:flutter/material.dart';

import 'add_page.dart';
import 'expenses_page.dart';
import 'home_page.dart';
import 'info_page.dart';
import 'models/circle.dart';
import 'models/item.dart';
class TaskPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  TaskPage({Key? key, required this.title, required this.circle}) : super(key: key);
  final String title;
  Circle circle;
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  List<Item> i1 = <Item>[];
  List<Item> i2 = <Item>[];
  List<Item> i3 = <Item>[];
  List<Item> i4 = <Item>[];

  List<List<Item>> orderedTasks = [];

  @override
  Widget build(BuildContext context) {

    List<Item> allTasks = widget.circle.getAllTasks();

    if(!allTasks.isEmpty) {
      //Traverse through tasks to order them by date and put into 2d list:
      //TODO: For now im hard coding this to get the example up:
      i1.add(allTasks[0]);
      i1.add(allTasks[1]);
      i1.add(allTasks[2]);

      i2.add(allTasks[3]);

      i3.add(allTasks[4]);
      i3.add(allTasks[5]);


      /* for(int index = 0; index < allTasks.length; index++){
      Item currTask = allTasks[index];
      DateTime currDate = currTask.getDate();
      List<Item> currListForDate = <Item>[currTask];

      //!(dueDate.compareTo(DateTime(1999)) == 0)
      for(int j = index+1; j < allTasks.length; j++){
        //if(j != index){
          Item otherTask = allTasks[j];
          DateTime otherDate = otherTask.getDate();

          //If have same date --> add to list
          if(currDate.compareTo(otherDate) == 0){
            currListForDate.add(otherTask);
          }
        //}
      }
      orderedTasks.add(currListForDate);
    }*/

      orderedTasks = [
        i1, i2, i3
      ];
      print("Length of orderedTasks: " + orderedTasks.length.toString());
    }


    //Everything im pasting in:

    return Scaffold(
/*      appBar: AppBar(
        title: Text(widget.title),
      ),*/
        backgroundColor: Color(0xFFD5F3FE),
        bottomNavigationBar: Container(
          height: 50,
          child: BottomAppBar(
              color: Color(0xFF2565AE),
              shape: const CircularNotchedRectangle(),
              child: Row(
                children: [
                  //1.) Home Button: HomePage
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => HomePage(title: widget.title, circle: widget.circle)));
                        },
                        icon: Icon(Icons.home_filled, color: Colors.white)
                    ),
                  ),

                  //2.) Task Icon: TaskPage
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => TaskPage(title: widget.title, circle: widget.circle)));
                          }
                        },
                        icon: Icon(Icons.list_alt_outlined, color: Colors.white)
                    ),
                  ),

                  //3.) Add Icon: Add Dialog page - TODO
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          /*showDialog(
                              context: context,
                              builder: (context) {
                                return SimpleDialog(
                                  title: Text('Choose an Option'),
                                  children: <Widget>[
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Option 1'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Option 2'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Option 3'),
                                    ),
                                    SimpleDialogOption(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Option 4'),
                                    ),
                                  ],
                                );
                              });*/

                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddPage(title: widget.title, circle: widget.circle)));
                        },
                        icon: Icon(Icons.add_circle_outline, color: Colors.white)
                    ),
                  ),

                  //4.) Money Icon: ExpensesPage - TODO: fix overflow
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ExpensesPage(title: widget.title, circle: widget.circle)));
                        },
                        icon: Icon(Icons.monetization_on_outlined, color: Colors.white)
                    ),
                  ),

                  //5.) Info Icon: InfoPage
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => InfoPage(title: widget.title, circle: widget.circle)));
                        },
                        icon: Icon(Icons.info_outlined, color: Colors.white)
                    ),
                  ),

                ],
              )
          ),
        ),

        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0xFFD5F3FE),
                    //Color(0xFF66D3FA),
                    Color(0xFF3C99DC),
                    Color(0xFF2565AE)
                    //Color(0xFF2565AE),
                  ],
                )
            ),
            child: Center(
                child:
                SingleChildScrollView(
                    child: Column(
                        children: [
                          //Child #1: Title - What are we adding?
                          Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 20, top: 50),
                                  child: Text(
                                    'Just your tasks,',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ),
                              ]
                          ),

                          /*//Child #2: Button to Change data to Master List
                    Container(
                      margin: EdgeInsets.only(top: 5, bottom: 10),
                      child: ElevatedButton(
                          onPressed: (){},
                          child: Text('See House Master List')
                      ),
                    ),*/


                          //Child #3: Whole bulk of page:
                          Column(
                              children: [
                                ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: orderedTasks.length,
                                    itemBuilder: (BuildContext context, int row) {

                                      //Transparent box to capture label and data:
                                      return Container(
                                          margin: EdgeInsets.only(top: 15),
                                          child: Column(
                                              children: [

                                                //1.) Day Label:
                                                Row(
                                                  children: [
                                                    Container(
                                                      alignment: Alignment.topLeft,
                                                      margin: EdgeInsets.only(
                                                          left: 20),
                                                      child: Text(orderedTasks[row][0].getDateString(),
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                          )
                                                      ),
                                                    ),
                                                    Spacer(),
                                                    Container(
                                                      alignment: Alignment.topRight,
                                                      margin: EdgeInsets.only(right: 8),
                                                      child: IconButton(
                                                          onPressed: (){
                                                            Navigator.push(context, MaterialPageRoute(
                                                                builder: (context) => AddPage(title: widget.title, circle: widget.circle)));
                                                          },
                                                          icon: Icon(Icons.add_circle_outline)
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                //2.) Day Data:
                                                //Transparent container since every task is in own box:
                                                Container(
                                                    width: 370,
                                                    height: 60.0*(orderedTasks[row].length),

                                                    child: ListView.builder(
                                                        itemCount: orderedTasks[row].length,
                                                        itemBuilder: (BuildContext context, int col){

                                                          //What each individual task looks like:
                                                          return Container(
                                                              width: 370,
                                                              height: 45,
                                                              margin: EdgeInsets.only(top: 10),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.white38,
                                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                                              ),
                                                              child: Row(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets.only(left: 15, right: 10),
                                                                      width: 30,
                                                                      height: 30,
                                                                      child: CircleAvatar(
                                                                        backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Ficon-icons.com%2Ficon%2Fmale-boy-person-people-avatar%2F159358&psig=AOvVaw0ibLF6R8vjZ3SCP9HiVhkg&ust=1637115663031000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCLjvoZ7pm_QCFQAAAAAdAAAAABAD'),
                                                                      ),
                                                                    ),

                                                                    Text(
                                                                      '${orderedTasks[row][col].getDescription()}',
                                                                      style: TextStyle(
                                                                        fontSize: 15,
                                                                      ),
                                                                    )
                                                                  ]
                                                              )
                                                          );
                                                        }
                                                    )
                                                )
                                              ]));
                                    })





                                //Day Data:
                                /*Container(
                                          width: 350,
                                          height: 130,
                                          decoration: BoxDecoration(
                                            color: Color(0xFFCDDEE8),
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                          ),

                                          child: ListView.builder(
                                            itemCount: orderedTasks[row].length,
                                            itemBuilder: (BuildContext context, int col){
                                              return Container(
                                                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      margin: EdgeInsets.only(right: 10),
                                                      width: 30,
                                                      height: 30,
                                                      child: CircleAvatar(
                                                        backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Ficon-icons.com%2Ficon%2Fmale-boy-person-people-avatar%2F159358&psig=AOvVaw0ibLF6R8vjZ3SCP9HiVhkg&ust=1637115663031000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCLjvoZ7pm_QCFQAAAAAdAAAAABAD'),
                                                      ),
                                                    ),

                                                    Text(
                                                      '${orderedTasks[row][col].getDescription()}',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.grey
                                                      ),
                                                    )
                                                  ]
                                                )
                                                    );
                                            }
                                            )
                                            )*/
                                /* ])
                                            );
                                  }
    ),*/
                                // )



                                /* Column(
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
                                      ),*/


                                /*Container(
                                margin: EdgeInsets.only(top: 30),  //margin to separate from top
                                child: Column(
                                    children: [

                                      //Today label:
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(left: 20),
                                        child: Text('Today, Friday 9/8:',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.grey
                                            )
                                        ),
                                      ),

                                      //Today data:
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

                                              //Tomorrow Label:
                                              Container(
                                                alignment: Alignment.topLeft,
                                                margin: EdgeInsets.only(left: 20),
                                                child:
                                                Text('Tomorrow, Wednesday 9/8:',
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey
                                                    )
                                                ),
                                              ),

                                              //Tomorrow Data:
                                              Container(
                                                width: 350,
                                                height: 1000,
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
                                                            child:
                                                              Text('- Buy tissue paper by @11:59pm')
                                                        )
                                                    ),

                                                    Expanded(child:
                                                      Container(
                                                          margin: EdgeInsets.only(left: 20, top: 10),
                                                          child:
                                                          Text('- Take out trash by @7pm')
                                                      )
                                                    ),

                                                    Expanded(child:
                                                      Container(
                                                          margin: EdgeInsets.only(left: 20, top: 10, bottom: 15),
                                                          child:
                                                            Text('...')

                                                      )
                                                    ),
                                                  ],
                                                ),
                                              )

                                            ]
                                        ),
                                      )
                                      //End of Tomorrow Section


                                    ]//TODO: The issue = Tomorrow section is still in the Today section?
                                )
                            )
                                    //End of Today Section

                          ] //End of List of Children for all data on screen
                    )
                ], //End of all Children for entire screen, including app bar
              )
            )*/



                                /*Expanded(
              flex: 10,
                child: Container(
                  color: Color(0xFFC9E3DA),
                  width: 400,
                  alignment: Alignment.center,
                  child: Text(
                        'All Your Things',
                        style: TextStyle(
                            fontSize: 20,
                          *//*color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.red,
                          decorationStyle: TextDecorationStyle.wavy,*//*
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
    )*/
                              ]
                          )
                        ]
                    )
                )
            )));
  }
}










//End of paste:























    //Everything im commenting out:
    /*return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Colors.white,
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
                              builder: (context) => HomePage(title: widget.title, circle: widget.circle)));
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
                                builder: (context) => TaskPage(title: widget.title, circle: widget.circle)));
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
                              builder: (context) => AddPage(title: widget.title, circle: widget.circle)));
                        },
                        icon: Icon(Icons.add_circle_outline)
                    ),
                  ),

                  //4.) Money Icon: ExpensesPage - TODO: fix overflow
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ExpensesPage(title: widget.title, circle: widget.circle)));
                        },
                        icon: Icon(Icons.monetization_on_outlined)
                    ),
                  ),

                  //5.) Info Icon: InfoPage
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => InfoPage(title: widget.title, circle: widget.circle)));
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
                      color: Color(0xFFDEEBF3),
                      width: 400,
                      alignment: Alignment.center,
                      child: Text(
                          'Your Task List: 9/7 - 9/20',
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
                                    child: Text('Regular Tasks:',
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
                                        color: Color(0xFFDBF0E9),
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
                                        child: Text('Unique Tasks:',
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
                                            color: Color(0xFFDBF0E9),
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

*/