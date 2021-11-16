import 'package:chums/add_dialog.dart';
import 'package:chums/task_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_page.dart';
import 'expenses_page.dart';
import 'info_page.dart';
import 'models/circle.dart';
import 'models/item.dart';
import 'models/user.dart';
class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  HomePage({Key? key, required this.title, required this.circle}) : super(key: key);
  final String title;
  Circle circle;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /*List<Item> orderedTasks = <Item>[
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 8)),
    Item(1, 'Take out trash', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 8)),
    Item(1, 'Take out trashhh', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 8)),
    Item(1, 'someething here', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 8)),
    Item(1, 'Something therre', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 9)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 10)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 10)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 11)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 15)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 15)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 15)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 16)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 23)),
    Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 23)),
  ];*/

  List<Item> i1 = <Item>[
 /* Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)),
  Item(1, 'Take out trash', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)),
  Item(1, 'Take out trashhh', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)),
  Item(1, 'someething here', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8))*/
  ];

  List<Item> i2 = <Item>[/*Item(1, 'Something therre', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 9))*/];
  List<Item> i3 = <Item>[
  /*Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 10)),
  Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 10)),*/
  ];
  List<Item> i4 = <Item>[
/*
  Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 15)),
  Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 9, 15)),*/
  ];

  List<List<Item>> orderedTasks = [];


  //List<User> test = <User>[User("Nobob", "pass", "email", "Po", "Lam")];
  List<Item> announcements = <Item>[
    /*Item(2, 'Meeting for HW #2, CS 4310', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 10, 11)),
    Item(2, 'Martha\'s family visiting', User("loluser", "pass", "email", "Po", "Lam"), null, DateTime(2021, 10, 11)),
    Item(2, 'Water filter broken, we need to find another', User("heyBob", "pass", "email", "Po", "Lam"), null, null)*/
  ];


  @override
  Widget build(BuildContext context) {
    List<Item> allTasks = widget.circle.getAllTasks();
    if(allTasks.isEmpty){
      print("alltasks is empty still");
    }
    else{
      print("allTasks not empty");
    }
    List<Item> announcements = widget.circle.getAllAnnouncements();
    List<Item> reminders = widget.circle.getAllReminders();
    List<Item> expenses = widget.circle.getAllExpenses();
    print("In home page, received these firsts: task = " + allTasks[0].getDescription() + "   announcement= " + announcements[0].getDescription() );/*+ "   reminder = " + reminders[0].getDescription()+ "   expenses= " + expenses[0].getDescription());*/

    Item i = announcements[0];

    //Traverse through tasks to order them by date and put into 2d list:
    //TODO: For now im hard coding this to get the example up:
    i1.add(allTasks[0]);
    i1.add(allTasks[1]);
    i1.add(allTasks[2]);

    i2.add(allTasks[3]);

    i3.add(allTasks[4]);
    i3.add(allTasks[5]);
    orderedTasks = [
        i1,i2,i3
    ];
    print("String here: " + orderedTasks.length.toString());

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
                          showDialog(
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
                              });

                          /*Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddPage(title: widget.title)));*/
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
                            'Hello Jo,',
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

                            //Child #3a: Announcements - Column
                            Column(
                                children: [
                                  //Announcement Label:
                                  Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.topLeft,
                                        margin: EdgeInsets.only(left: 20, top: 20),
                                        child: Text('Announcements',
                                            style: TextStyle(
                                                fontSize: 24,
                                            )
                                        ),
                                      ),
                                      Spacer(),
                                      Container(
                                        alignment: Alignment.topRight,
                                        margin: EdgeInsets.only(right: 8, top: 25 ),
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

                                  //Announcement Data:
                                  Container(
                                    width: 370,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        color: Colors.white38,
                                        borderRadius: BorderRadius.all(Radius.circular(10))
                                    ),
                                    child:
                                        //List based on announcements
                                      ListView.builder(
                                          itemCount: announcements.length,
                                          itemBuilder: (BuildContext context, int index){
                                            return Container(
                                              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                              child: Column(
                                                children: [
                                                  Row(
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets.only(right: 10),
                                                          width: 30,
                                                          height: 30,
                                                          child: CircleAvatar(
                                                              backgroundImage: NetworkImage('https://www.google.com/url?sa=i&url=https%3A%2F%2Ficon-icons.com%2Ficon%2Fmale-boy-person-people-avatar%2F159358&psig=AOvVaw0ibLF6R8vjZ3SCP9HiVhkg&ust=1637115663031000&source=images&cd=vfe&ved=0CAsQjRxqFwoTCLjvoZ7pm_QCFQAAAAAdAAAAABAD'),
                                                          ),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Container(
                                                              margin: EdgeInsets.only(bottom: 5),
                                                              child: Text(
                                                                  '${announcements[index].getDescription()}',
                                                                  style: TextStyle(
                                                                    fontWeight: FontWeight.bold,
                                                                    fontSize:14
                                                                  )
                                                              ),
                                                            ),
                                                            Text('Due date: ${announcements[index].getDateString()}',
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: Colors.grey
                                                              ),
                                                            )
                                                          ],
                                                        )
                                                      ]
                                                  ),

                                                  Container(
                                                    margin: EdgeInsets.only(top: 10),
                                                    child: Divider(
                                                        height: 2,
                                                        thickness: 0.5,
                                                        indent:0,
                                                        endIndent:0,
                                                        color: Color(0xFF3C99DC)
                                                    ),
                                                  )
                                                ]
                                              )
                                            );
                                      })

                                    /*Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(child: Container(
                                            margin: EdgeInsets.only(left: 20, top: 15),
                                            child:
                                              Text('HW #2 for CS 4310 due on Friday 9/14'))),
                                        Divider(
                                            height: 2,
                                            thickness: 0.5,
                                            indent:0,
                                            endIndent:0,
                                            color: Color(0xFFD3D3D3)
                                        ),
                                        Expanded(child: Container(
                                            margin: EdgeInsets.only(left: 20, top: 10),
                                            child: Text('Martha\'s family visiting on Friday 9/14'))),
                                        Expanded(child: Container(
                                            margin: EdgeInsets.only(left: 20, top: 10, bottom: 15),
                                            child: Text('Water filter broken, we need to find another'))),
                                      ],
                                    ),*/
                                  ),
                                ]
                            ),


                          //Child #3b: Today section - Container
                            // All Tasks:
                           /* Container(
                                margin: EdgeInsets.only(top: 30),
                                width: 370,
                                //height: 200,
                                decoration: BoxDecoration(
                                    color: Colors.white38,
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                              child:*/
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
