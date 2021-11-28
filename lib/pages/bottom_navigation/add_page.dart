import 'package:chum/add_dialog.dart';
import 'package:chum/models/items/expense.dart';
import 'package:chum/models/items/reminder.dart';
import 'package:chum/models/items/task.dart';
import 'package:chum/sqLite/database.dart';
import 'package:flutter/material.dart';

import 'expenses_page.dart';
import 'home_page.dart';

import '../../constants.dart' as Constants;

//Purpose:  Given the Circle, we have access to all Tasks, Announcements, Reminders, and Expenses. We will update this Circle object and send it back to whoever called this page (us)
class AddPage extends StatefulWidget {

  //const HomePage({Key? key}) : super(key: key);
  AddPage({Key? key, required this.title, required this.page_from, required this.isEdit, selectedTask, selectedReminder,selectedExpense}) :
        selectedTask = selectedTask ?? Task(id:-1, description:"null", dueDate: DateTime(1999)),
        selectedReminder = selectedReminder ?? Reminder(id:-1, description:"null", dueDate: DateTime(1999)),
        selectedExpense = selectedExpense ?? Expense(id:-1, description:"null", cost:0, dueDate: DateTime(1999)),
        super(key: key);

  final String title;
  final String page_from;
  bool isEdit;
  Task selectedTask;
  Reminder selectedReminder;
  Expense selectedExpense;


  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  String dropdownValue = 'One';

  //Values to store to create new Item:
  String taskType = 'Task';
  String description = "";

  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();

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

    //Get all data needed and make Item object:
    switch(taskType) {
      case 'Task':
        if(widget.isEdit){
          Task updatedTask = new Task(id:widget.selectedTask.getId(), description: descriptionController.text, dueDate: selectedDate);
          DatabaseHelper.instance.updateTask(updatedTask.toMap());
        }
        else{
          Task newTask = new Task(id:-1, description: descriptionController.text, dueDate: selectedDate);
          DatabaseHelper.instance.insertTask(newTask.toMapWithoutId());
        }
        break;
      case 'Reminder':
        if(widget.isEdit){
          Reminder updatedReminder = new Reminder(id:widget.selectedReminder.getId(), description: descriptionController.text, dueDate: selectedDate);
          DatabaseHelper.instance.updateReminder(updatedReminder.toMap());
        }
        else{
          Reminder newReminder = new Reminder(id:-1, description: descriptionController.text, dueDate: selectedDate);
          DatabaseHelper.instance.insertReminder(newReminder.toMapWithoutId());
        }
        break;
      case 'Expense':
        if(widget.isEdit){
          Expense updatedExpense = new Expense(id:widget.selectedExpense.getId(), description: descriptionController.text, cost: double.parse(costController.text), dueDate: selectedDate);
          DatabaseHelper.instance.updateExpense(updatedExpense.toMap());
        }
        else{
          Expense newExpense = new Expense(id:-1, description: descriptionController.text, cost: double.parse(costController.text), dueDate: selectedDate);
          DatabaseHelper.instance.insertExpense(newExpense.toMapWithoutId());
        }
        break;
      default:
        break;
    }

    //2.) Go back to the page came from passing along the new task
    //Should prob not put this here buut you know - Make sure page_from is valid page --> go to that page with updated list.
    switch(widget.page_from){
      case Constants.KEY_HOME:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomePage(title: widget.title)));
        break;
      case Constants.KEY_EXPENSES:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ExpensesPage(title: widget.title,)));
        break;
      case Constants.KEY_ADD:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddPage(title: widget.title, page_from: widget.page_from, isEdit: widget.isEdit, selectedExpense: widget.selectedExpense, selectedTask: widget.selectedTask, selectedReminder: widget.selectedReminder,)));
        break;
      default:
        print("add_page:  page_from was not valid, so did not navigate back from anywhere");
        break;
    }
  }

  //Purpose: Called automatically to build the page:
  @override
  Widget build(BuildContext context) {
    //If we are editing something, pre-fill values
    if (widget.isEdit) {
      print("yes we are editing something");
      if(widget.selectedTask.getId() == -1){
        descriptionController.text = widget.selectedTask.getDescription();
        selectedDate = widget.selectedTask.getDate();
        taskType = "Task";
      }
      else if(widget.selectedExpense.getId() == -1){
        descriptionController.text = widget.selectedExpense.getDescription();
        selectedDate = widget.selectedExpense.getDate();
        costController.text = widget.selectedExpense.getCost().toString();
        taskType = "Expense";
      }
      else{
        descriptionController.text = widget.selectedReminder.getDescription();
        selectedDate = widget.selectedReminder.getDate();
        taskType = "Reminder";
      }
    }


    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 72),
                    child: Text('Add New Item')),
                Spacer(),
                IconButton(onPressed: (){
                  print("You pushed the settings button");
                },
                    icon: Icon(Icons.view_headline_outlined))
              ],
            ),
            backgroundColor: Color(0xFF3C99DC),
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios_outlined),
                onPressed: () //TODO: Define a back button function, also this pops off the current screen so yes good stuff - Navigator.of(context).pop(),
                {
                  print("hi you pushed the back button");
                }
            )
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
                              builder: (context) => HomePage(title: widget.title,)));
                        },
                        icon: Icon(Icons.home_filled, color: Colors.white)
                    ),
                  ),

                  //3.) Add Icon: Add Dialog page - TODO
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddPage(title: widget.title, page_from: widget.page_from,isEdit: widget.isEdit, selectedExpense: widget.selectedExpense, selectedTask: widget.selectedTask, selectedReminder: widget.selectedReminder,)));
                        },
                        icon: Icon(Icons.add_circle_outline, color: Colors.white)
                    ),
                  ),

                  //4.) Money Icon: ExpensesPage - TODO: fix overflow
                  Expanded(
                    child: IconButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => ExpensesPage(title: widget.title, )));
                        },
                        icon: Icon(Icons.monetization_on_outlined, color: Colors.white)
                    ),
                  ),
                ],
              )
          ),
        ),

      body:Container(
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
          child: Column(
              children:[
          SingleChildScrollView(
            child: Column(
                children: [

                  //Question 1: What item we adding?
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top:15, left: 15, right: 60),
                          child:
                            Text("Item Type",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              )
                            )
                      ),

                      Container(
                        margin: EdgeInsets.only(top:15, left: 15, right: 60),
                        child:DropdownButton<String>(
                          value: taskType,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: const TextStyle(color: Color(0xFF0F5298)),
                          underline: Container(
                            height: 2,
                            color: Color(0xFF2565AE),
                          ),
                          onChanged: (String? newValue) {
                            setState(() {
                              taskType = newValue!;
                            });
                          },
                          items: <String>['Task', 'Reminder', 'Expense']
                              .map<DropdownMenuItem<String>>((String value) {
                                if(value == "Expense"){
                                  //TODO: Show/hide the Cost question
                                }
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                          }).toList(),
                        ),
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
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    height: 30,
                    child: TextField(
                      controller: descriptionController,
                     // cursorColor: Color(0xFF0F5298),
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                        ),
                        labelText: 'Enter here...',
                      ),
                    ),
                  ),

                  //Toggled if item = expense:
          //Question: Cost?
                  //Title:
                  Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(left: 15, top:15),
                    child: Text("$taskType Cost",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    height: 30,
                    child: TextField(
                      controller: costController,
                      // cursorColor: Color(0xFF0F5298),
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
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
                                fontWeight: FontWeight.bold,
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
                              border: Border.all(color: Color(0xFF3C99DC)),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Text('$selectedDate',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                color: Color(0xFF2565AE)
                              )
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
    ])
        //Child #1: Title - What are we adding?
    ));
  }
}
