import 'package:chums/task_page.dart';
import 'package:flutter/material.dart';

import 'expenses_page.dart';
import 'home_page.dart';
import 'info_page.dart';
import 'models/circle.dart';
import 'models/item.dart';
import 'models/user.dart';
class AddPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  AddPage({Key? key, required this.title, required this.circle}) : super(key: key);
  final String title;
  Circle circle;
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  String assignedChum = 'None';
  String taskType = 'Task';
  String assignedRole = 'Role #1';
  String description = "";

  TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();


  //Purpose: Allow user to select a date, save selectedDate as global variable
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  //Purpose: When creation of item is done, create an Item object and store it:
  _createItem(BuildContext context){
    print("pressed it");
    print(descriptionController.text);
    print("circle = " + widget.circle.toString());

    //Get all data needed and make Item object:
    int type;
    switch(taskType) {
      case 'Task':
        type = 1;
        break;
      case 'Announcement':
        type = 2;
        break;
      case 'Reminder':
        type = 3;
        break;
      case 'Expense':
        type = 4;
        break;
      default:
        type = -1;
        break;
    }
    User authorLol = User("Nobob", "pass", "email", "Po", "Lam", null);

    //Need to change this to actually look up the User object lol:
    List<User> assignedMembers = <User>[];
    if(assignedChum != "None"){
      assignedMembers.add(User(assignedChum, "pass", "email", assignedChum, "Lam", null));
    }
    Item newItem = Item(type, descriptionController.text, authorLol, assignedMembers, selectedDate);
    widget.circle.addItem(newItem);

    //2.) Go back to the page came from passing along the new task TODO: this obvi doesn't work because it wouldn't update any task list if we came from a page that doesn't have a task list.
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomePage(title: widget.title, circle: widget.circle,)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
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

      body:
        Center(
          child:
          SingleChildScrollView(
            child: Column(
                children: [
                  //Title:
                  Text("Add new item",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )
                  ),

                  //Question 1: What item we adding?
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 60),
                          child:
                            Text("Item Type",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 16,
                              )
                            )
                      ),

                      DropdownButton<String>(
                        value: taskType,
                        icon: const Icon(Icons.arrow_downward),
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            taskType = newValue!;
                          });
                        },
                        items: <String>['Task', 'Announcement', 'Reminder', 'Expense']
                            .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                        }).toList(),
                      ),
                    ],
                  ),

                  //Question 2: Description
                  //Title:
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15, top:15),
                    child: Text("$taskType Description",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    height: 30,
                    child: TextField(
                      controller: descriptionController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        ),
                        labelText: 'Enter here...',
                      ),
                    ),
                  ),

                  //Question #3: Due date?
                  Container(
                    margin: EdgeInsets.only(top:15),
                    child: Row(
                      children: [
                        //Date Label:
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 5),
                          height: 30,
                          child: Text("Due Date:  ",
                              style: TextStyle(
                                fontSize: 16,
                              )
                          ),
                        ),

                        //Calendar Icon to pick:
                        IconButton(
                            onPressed: () => _selectDate(context),
                            iconSize: 20,
                            icon: Image.asset('assets/calendar_icon.png')
                        ),

                        //Place to display chosen date/time:
                        Container(
                          margin: EdgeInsets.only(left: 35),
                          height: 30,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)
                          ),
                          child: Text('$selectedDate',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Question 4 and 5: Assign to role? Assign to person?
                  Container(
                    margin: EdgeInsets.only(top:15),
                    child: Row(
                      children: [
                        //Assign Label to Chum:
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 10),
                          height: 30,
                          child: Text("Assign to a Chum?  ",
                              style: TextStyle(
                                fontSize: 16,
                              )
                          ),
                        ),

                        //Dropdown of possible chums:
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: DropdownButton<String>(
                            value: assignedChum,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                assignedChum = newValue!;
                              });
                            },
                            items: <String>['Doug', 'Barry', 'Brooke', 'Lori', 'None']
                                .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                );
                            }).toList(),
                          ),
                        ),

                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top:10),
                    child: Row(
                      children: [
                        //Assign Label to Chum:
                        Container(
                          margin: EdgeInsets.only(left: 20, right: 20),
                          height: 30,
                          child: Text("Assign to a Role?  ",
                              style: TextStyle(
                                fontSize: 16,
                              )
                          ),
                        ),

                        //Dropdown of possible chums:
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: DropdownButton<String>(
                            value: assignedRole,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                assignedRole = newValue!;
                              });
                            },
                            items: <String>['Role #1', 'Role #2', 'Role #3']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),

                      ],
                    ),
                  ),

                  //Submission button:
                  ElevatedButton(
                      onPressed: () => _createItem(context),
                      child: Text(
                        'Done',
                        textAlign: TextAlign.center,
                      )
                  )

                ]
    )
        )
    )
        //Child #1: Title - What are we adding?
    );
  }
}
