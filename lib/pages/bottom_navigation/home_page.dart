import 'package:chums/add_dialog.dart';
import 'package:chums/pages/bottom_navigation/task_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_page.dart';
import 'expenses_page.dart';
import 'info_page.dart';
import '../../models/circle.dart';
import '../../models/item.dart';
import '../../models/user.dart';
import '../../constants.dart' as Constants;


class HomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  HomePage({Key? key, required this.title, required this.circle}) : super(key: key);
  final String title;
  Circle circle;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {









  List<Item> i1 = <Item>[];
  List<Item> i2 = <Item>[];
  List<Item> i3 = <Item>[];
  List<Item> i4 = <Item>[];

  List<List<Item>> orderedTasks = [];


  //List<User> test = <User>[User("Nobob", "pass", "email", "Po", "Lam")];
  List<Item> announcements = <Item>[
    /*Item(2, 'Meeting for HW #2, CS 4310', User("heyBob", "pass", "email", "Po", "Lam"), null, DateTime(2021, 10, 11)),
    Item(2, 'Martha\'s family visiting', User("loluser", "pass", "email", "Po", "Lam"), null, DateTime(2021, 10, 11)),
    Item(2, 'Water filter broken, we need to find another', User("heyBob", "pass", "email", "Po", "Lam"), null, null)*/
  ];


  @override
  Widget build(BuildContext context) {
    print("building home page");
    List<Item> allTasks = widget.circle.getAllTasks();
    announcements = widget.circle.getAllAnnouncements();

    orderedTasks = widget.circle.getOrderedListByDate(Constants.TASK_LIST);

    //TODO: Will need to fix to make all Reminders and Expenses be a Task (So yes will need to make Reminders and Expenses child of a Task class
   /* if(!allTasks.isEmpty) {

      //Assume all items should always be sorted:
      for(int i = 0; i < allTasks.length; i++){
        //Assume new date --> need a new row/list:
        List<Item> newDate = <Item>[];
        newDate.add(allTasks[i]);

        DateTime dateOfItems = allTasks[i].getDate();
        for(int j = i+1; j < allTasks.length; j++){
          Item otherItem = allTasks[j];
          DateTime otherDate = otherItem.getDate();

          print("date = " + dateOfItems.toString() + "  otherdate = " + otherDate.toString() + " i = " + i.toString() + "  j = " + j.toString());
          //If date is same, add this item to list, then check other items
          if(dateOfItems.compareTo(otherDate) == 0){
            newDate.add(otherItem);

            //If we are at the end of the list, make sure to update i one last time to get out of both loops (since i has no postcondition)
            *//*if(j == allTasks.length-1){
              i = j;
              break;
            }*//*
          }
          else{ //otherwise, date is different, so make i jump to = j to make a new list from there
            i = j-1;
            break;
          }
        }

        //Add this new list to the 2d list:
        orderedTasks.add(newDate);
        print("i " + i.toString());
        *//*if(i == allTasks.length){
          break;
        }*//*
      }*/











      //Traverse through tasks to order them by date and put into 2d list:
      //TODO: For now im hard coding this to get the example up:
     /* i1.add(allTasks[0]);
      i1.add(allTasks[1]);
      i1.add(allTasks[2]);

      i2.add(allTasks[3]);

      i3.add(allTasks[4]);
      i3.add(allTasks[5]);
*/

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

    /*  orderedTasks = [
        i1, i2, i3
      ];*/

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
                              builder: (context) => AddPage(title: widget.title, circle: widget.circle, page_from: Constants.KEY_HOME)));
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
                              fontSize: 35,
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
                                        margin: EdgeInsets.only(left: 20, top: 5),
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
                                                  builder: (context) => AddPage(title: widget.title, circle: widget.circle, page_from: Constants.KEY_HOME)));
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
                                  ),
                                ]
                            ),

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
                                                                builder: (context) => AddPage(title: widget.title, circle: widget.circle, page_from: Constants.KEY_HOME)));
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
  ]
    )
          ]
    )
    )
    )));
  }
}
