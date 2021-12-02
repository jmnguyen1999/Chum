

import 'package:chum/models/items/reminder.dart';
import 'package:chum/models/items/task.dart';
import 'package:chum/sqLite/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart' as Constants;
import '../settings/settings_page.dart';
import 'add_page.dart';
import 'expenses_page.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<Task>> allTasks = [];
  List<Reminder> allReminders = [];
  List<bool> _isChecked = [];
  int numTasks = 0;

  void getTasks() async {
    List<Map<String, dynamic>> listMap = await DatabaseHelper.instance.queryAllTasks();
    List<Task> listTasks = [];
    listMap.forEach((map) => listTasks.add(Task.fromMap(map)));
    setState(() {
      allTasks = Task(id:9879, description: "null", dueDate: DateTime(1999)).getTasksByDate(listTasks);
      print("Task list from getTasks(): " + allTasks.toString());
    });
  }
  void getReminders() async {
    List<Map<String, dynamic>> listMap = await DatabaseHelper.instance.queryAllReminders();
    setState(() {
      listMap.forEach((map) => allReminders.add(Reminder.fromMap(map)));
      print("Reminders list from getReminders: " + allReminders.toString());
    });
  }

  @override
  void initState() {
    getTasks();
    getReminders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double remindersHeight = (90*allReminders.length).toDouble();
    if(allReminders.length == 0 && allTasks.length == 0){
      /*print("no reminders or tasks yet");
      Task t = Task(id:-1, description: "Here's your first task: Create more!! :)", dueDate: DateTime.now());
      List<Task> tt = [t];
      allTasks.add(tt);
      remindersHeight = 70;
      allReminders.add(Reminder(id: -1, description: "You have no reminders!"));*/
      remindersHeight = 100;
    }

    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Color(0xFF2565AE);
      }
      return Color(0xFF0F5298);
    }

    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Container(
                  child: Text('Home')
              ),
              Spacer(),
              IconButton(onPressed: (){
                print("You pushed the settings button");
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SettingsPage(title: widget.title)));
              },
                  icon: Icon(Icons.view_headline_outlined))
            ],
          ),
          backgroundColor: Color(0xFF3C99DC),
        ),
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
                              builder: (context) => HomePage(title: widget.title)));
                        },
                        icon: Icon(Icons.home_filled, color: Colors.white)
                    ),
                  ),
                  //3.) Add Icon: Add Dialog page - TODO
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_HOME, isEdit: false, isNew:false)));
                        },
                        icon: Icon(Icons.add_circle_outline, color: Colors.white)
                    ),
                  ),

                  //4.) Money Icon: ExpensesPage - TODO: fix overflow
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ExpensesPage(title: widget.title)));
                        },
                        icon: Icon(Icons.monetization_on_outlined, color: Colors.white)
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
                    Color(0xFF3C99DC),
                    Color(0xFF2565AE)
                  ],
                )
            ),
            child: Column(
                children:[Expanded(
                  child: SingleChildScrollView(
                      child: Column(
                          children: [
                            //Child #1: Title - What are we adding?
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20, top:30),
                              child: Text(
                                'Hi there,',
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Lato',
                                ),
                              ),
                            ),

                            //Child #3: Whole bulk of page:
                            Column(
                                children: [
                                  //Divider
                                  Container(
                                    margin: EdgeInsets.only(top: 35, left:20, right:20),
                                    child: Divider(
                                        height: 1,
                                        thickness: 2,
                                        indent:0,
                                        endIndent:0,
                                        color: /*Color(0xFF3C99DC)*/Colors.black
                                    ),
                                  ),
                                  //Child #3a: Reminders - Column
                                  Column(
                                      children: [
                                        //Reminder Label:
                                        Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.topLeft,
                                              margin: EdgeInsets.only(left: 20),
                                              child: Text('Reminders',
                                                  style: TextStyle(
                                                      fontSize: 26,
                                                      fontWeight: FontWeight.bold
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
                                                        builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_HOME, isEdit: false, isNew:true, selectedReminder: new Reminder(id:0, description:"", dueDate:null),)));
                                                  },
                                                  icon: Icon(Icons.add_circle_outline)
                                              ),
                                            ),
                                          ],
                                        ),

                                        //Announcement Data:
                                        Container(
                                            width: 370,
                                            //height: remindersHeight,
                                            decoration: BoxDecoration(
                                                color: Colors.white38,
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child:
                                            //List based on announcements
                                            ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: allReminders.length,
                                                itemBuilder: (BuildContext context, int index){
                                                  final reminder = allReminders[index].getDescription();
                                                  return ListTile(
                                                    onTap: (){
                                                      print("ListTile tapped from homepage, sending task: " + allReminders[index].getDescription());
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_HOME, isEdit:true, isNew:false,selectedReminder:allReminders[index])));
                                                    },
                                                    title: Dismissible(
                                                      key: UniqueKey(),
                                                      onDismissed: (direction) {
                                                        print("reminder id to delete: " + allReminders[index].getId().toString());
                                                        DatabaseHelper.instance.deleteReminder(allReminders[index].getId());
                                                        setState(() {
                                                          allReminders.removeAt(index);
                                                        });
                                                        // Then show a snackbar.
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(SnackBar(content: Text('$reminder deleted')));
                                                      },
                                                      background: Container(color: Color(0xFF2565AE)),
                                                      child: Container(
                                                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                    children: [
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            margin: EdgeInsets.only(bottom: 5, right:10),
                                                                            child:Flexible(
                                                                              child: Text(
                                                                                      '${allReminders[index].getDescription()}',
                                                                                      style: TextStyle(
                                                                                          fontWeight: FontWeight.bold,
                                                                                          fontSize:14
                                                                                      )
                                                                                  ),
                                                                            ),
                                                                            ),
                                                                           Container(
                                                                             margin: EdgeInsets.only(right:10),
                                                                             child: Text('Due date: ${allReminders[index].getDateString()}',
                                                                              style: TextStyle(
                                                                                  fontSize: 12,
                                                                                  color: Colors.grey
                                                                                ),
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
                                                      ),
                                                    ),
                                                  );
                                                })
                                        ),
                                      ]
                                  ),

                                  //Divider between Tasks and Reminders section:
                                  Container(
                                    margin: EdgeInsets.only(top: 35, left:20, right:20),
                                    child: Divider(
                                        height: 1,
                                        thickness: 2,
                                        indent:0,
                                        endIndent:0,
                                        color: /*Color(0xFF3C99DC)*/Colors.black
                                    ),
                                  ),

                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.only(left: 20, top: 20),
                                    child: Text('Tasks:',
                                        style: TextStyle(
                                            fontSize: 26,
                                            fontWeight: FontWeight.bold
                                        )
                                    ),
                                  ),

                                  ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: allTasks.length,
                                      itemBuilder: (BuildContext context, int row) {

                                        //Transparent box to capture label and data:
                                        return Column(
                                            children:[
                                              Container(
                                                margin: EdgeInsets.only(bottom: 10),
                                                child: Column(
                                                    children: [

                                                      //1.) Day Label:
                                                      Row(
                                                        children: [
                                                          Container(
                                                            alignment: Alignment.topLeft,
                                                            margin: EdgeInsets.only(
                                                                left: 20),
                                                            child: Text(allTasks[row][0].getDateString(),
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontWeight: FontWeight.bold
                                                                )
                                                            ),
                                                          ),
                                                          Spacer(),

                                                          //Add button next to Date
                                                          Container(
                                                            alignment: Alignment.topRight,
                                                            margin: EdgeInsets.only(right: 8),
                                                            child: IconButton(
                                                                onPressed: (){
                                                                  Navigator.push(context, MaterialPageRoute(
                                                                      builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_HOME, isEdit:false, isNew:true, selectedTask: new Task(id:0, description: "", dueDate: DateTime.parse(allTasks[row][0].getDate().toString())),)));
                                                                },
                                                                icon: Icon(Icons.add_circle_outline)
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      //2.) Day Data:
                                                      //Transparent container since every task is in own box:
                                                      Container(
                                                          margin: EdgeInsets.only(),
                                                          width: 370,
                                                          //height: 70.0*(allTasks[row].length),

                                                          child: ListView.builder(
                                                              shrinkWrap: true,
                                                              itemCount: allTasks[row].length,
                                                              itemBuilder: (BuildContext context, int col){
                                                                final task = allTasks[row][col];
                                                                //What each individual task looks like:
                                                                return ListTile(
                                                                  onTap: (){
                                                                    print("ListTile tapped from homepage, sending task: " + allTasks[row][col].getDescription());
                                                                    Navigator.push(context, MaterialPageRoute(
                                                                        builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_HOME, isEdit:true, isNew: false, selectedTask:allTasks[row][col])));
                                                                  },
                                                                  title: Dismissible(
                                                                    key: UniqueKey(),
                                                                    onDismissed: (direction) {
                                                                      print("reminder id to delete: " + allTasks[row][col].getId().toString());
                                                                      DatabaseHelper.instance.deleteTask(allTasks[row][col].getId());
                                                                      setState(() {
                                                                        allTasks.removeAt(row).removeAt(col);
                                                                      });
                                                                      // Then show a snackbar.
                                                                      ScaffoldMessenger.of(context)
                                                                          .showSnackBar(SnackBar(content: Text('$task deleted')));
                                                                    },
                                                                    background: Container(color: Color(0xFF2565AE)),
                                                                    child: Container(
                                                                        width: 370,
                                                                        //height: 45,
                                                                        margin: EdgeInsets.only(top: 5),
                                                                        decoration:
                                                                        BoxDecoration(
                                                                            color: Colors.white38,
                                                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                                                        ),
                                                                        child:
                                                                        Container(
                                                                          margin: EdgeInsets.only(top: 5, bottom: 5, right: 15),
                                                                          child: Row(
                                                                              children: [
                                                                                Container(
                                                                                    margin: EdgeInsets.only(left: 15, right: 10),
                                                                                    width: 30,
                                                                                    height: 30,
                                                                                    child:
                                                                                    Checkbox(
                                                                                      checkColor: Colors.white,
                                                                                      fillColor: MaterialStateProperty.resolveWith(getColor),
                                                                                      value: allTasks[row][col].getIsDone(),
                                                                                      onChanged: (bool? value) {
                                                                                        setState(() {
                                                                                          allTasks[row][col].isDone = value!;
                                                                                        });
                                                                                      },
                                                                                    )
                                                                                ),

                                                                                Flexible(
                                                                                  child: Text(
                                                                                    '${allTasks[row][col].getDescription()}',
                                                                                    style: TextStyle(
                                                                                      fontSize: 15,
                                                                                    ),
                                                                                  ),
                                                                                )
                                                                              ]
                                                                          ),
                                                                        )
                                                                    ),
                                                                  ),

                                                                );
                                                              }
                                                          )
                                                      )
                                                    ]),
                                              ),


                                              //Divider line below task days:
                                              Container(
                                                margin: EdgeInsets.only(top: 10, left:30, right:30, bottom: 10),
                                                child: Divider(
                                                    height: 1,
                                                    thickness: 1,
                                                    indent:0,
                                                    endIndent:0,
                                                    color: Color(0xFF0F5298)
                                                ),
                                              )
                                            ]);
                                      })
                                ]
                            )
                          ]
                      )
                  ),
                ),
                ]
            )));
  }
}
