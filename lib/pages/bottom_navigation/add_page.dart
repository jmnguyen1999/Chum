import 'package:chum/add_dialog.dart';
import 'package:chum/models/items/expense.dart';
import 'package:chum/models/items/reminder.dart';
import 'package:chum/models/items/task.dart';
import 'package:chum/sqLite/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../settings_page.dart';
import 'expenses_page.dart';
import '../../main.dart';

import '../../constants.dart' as Constants;

//Purpose:  Given the Circle, we have access to all Tasks, Announcements, Reminders, and Expenses. We will update this Circle object and send it back to whoever called this page (us)
class AddPage extends StatefulWidget {

  //const HomePage({Key? key}) : super(key: key);
  AddPage({Key? key, required this.title, required this.page_from, required this.isEdit, required this.isNew, selectedTask, selectedReminder,selectedExpense}) :
        selectedTask = selectedTask ?? Task(id:-1, description:"null", dueDate: DateTime(1999)),
        selectedReminder = selectedReminder ?? Reminder(id:-3, description:"null", dueDate: DateTime(1999)),
        selectedExpense = selectedExpense ?? Expense(id:-2, description:"null", cost:0, dueDate: DateTime(1999)),
        super(key: key);

  final String title;
  final String page_from;
  bool isEdit;
  bool isNew;         //Flag on whether or not to pre-fill info for a new item
  Task selectedTask;
  Reminder selectedReminder;
  Expense selectedExpense;


  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  @override
  //Purpose:      If new item to begin from specific page, upload item type and date if needed
  void initState() {
    if(widget.isNew){
      if(widget.selectedTask.getId() != -1){
        print("was a task");
        taskType = "Task";
        if(widget.selectedTask.hasDueDate() && picked != selectedDate){
          selectedDate = widget.selectedTask.getDate();
        }
      }
      else if(widget.selectedExpense.getId() != -2){
        print("was an expense");
        taskType = "Expense";
        if(widget.selectedExpense.hasDueDate() && picked != selectedDate){
          selectedDate = widget.selectedExpense.getDate();
        }
      }
      else{
        print("was a reminder");
        taskType = "Reminder";
        if(widget.selectedReminder.hasDueDate() && picked != selectedDate){
          selectedDate = widget.selectedReminder.getDate();
        }
      }
    }
    super.initState();
  }
  String dropdownValue = 'One';

  //Values to store to create new Item:
  String taskType = 'Task';
  String description = "";

  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime? picked = DateTime.now();

  //Purpose: Allow user to select a date, save selectedDate as global variable
  Future<void> _selectDate(BuildContext context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (widget.isEdit || (picked != null && picked != selectedDate)) {
      setState(() {
        selectedDate = picked!;
        print(selectedDate.toString());
      });
    }
  }

  //Purpose: When creation of item is done, create an Item object and store it:
  _createItem(BuildContext context) {
    bool noCostEntered = false;
    if (descriptionController.text != "") {
      //Get all data needed and make Item object:
      switch (taskType) {
        case 'Task':
          if (widget.isEdit) {
            Task updatedTask = new Task(id: widget.selectedTask.getId(),
                description: descriptionController.text,
                dueDate: selectedDate);
            DatabaseHelper.instance.updateTask(updatedTask.toMap());
          }
          else {
            Task newTask = new Task(id: -1,
                description: descriptionController.text,
                dueDate: selectedDate);
            DatabaseHelper.instance.insertTask(newTask.toMapWithoutId());
          }
          break;
        case 'Reminder':
          if (widget.isEdit) {
            Reminder updatedReminder = new Reminder(
                id: widget.selectedReminder.getId(),
                description: descriptionController.text,
                dueDate: selectedDate);
            DatabaseHelper.instance.updateReminder(updatedReminder.toMap());
          }
          else {
            Reminder newReminder = new Reminder(id: -1,
                description: descriptionController.text,
                dueDate: selectedDate);
            DatabaseHelper.instance.insertReminder(
                newReminder.toMapWithoutId());
          }
          break;
        case 'Expense':
          if (costController.text != "" && (double.tryParse(costController.text) != null)) {
            if (widget.isEdit) {
              Expense updatedExpense = new Expense(
                  id: widget.selectedExpense.getId(),
                  description: descriptionController.text,
                  cost: double.parse(costController.text),
                  dueDate: selectedDate);
              DatabaseHelper.instance.updateExpense(updatedExpense.toMap());
            }
            else {
              Expense newExpense = new Expense(id: -1,
                  description: descriptionController.text,
                  cost: double.parse(costController.text),
                  dueDate: selectedDate);
              DatabaseHelper.instance.insertExpense(
                  newExpense.toMapWithoutId());
            }
          }
          else {
            // Then change flag to not navigate to back page

            noCostEntered= true;
            if(double.tryParse(costController.text) == null){
              // Then show a snackbar.
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Cost entered is not valid!')));
            }
            else{
              // Then show a snackbar.
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Please fill out all areas.')));
            }
          }
          break;
        default:
          break;
      }

      //2.) Go back to the page came from passing along the new task
      if (!noCostEntered) {
        switch (widget.page_from) {
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
                builder: (context) =>
                    AddPage(title: widget.title,
                      page_from: widget.page_from,
                      isEdit: widget.isEdit,
                      isNew:widget.isNew,
                      selectedExpense: widget.selectedExpense,
                      selectedTask: widget.selectedTask,
                      selectedReminder: widget.selectedReminder,)));
            break;
          default:
            print(
                "add_page:  page_from was not valid, so did not navigate back from anywhere");
            break;
        }
      }
    }
    else{
      // Then show a snackbar.
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill out all areas.')));
    }
  }

  //Purpose: Called automatically to build the page:
  @override
  Widget build(BuildContext context) {

    //If we are editing something, pre-fill values
    if (widget.isEdit) {
      print("yes we are editing something");
      if(widget.selectedTask.getId() != -1){
        print("was a task");
        descriptionController.text = widget.selectedTask.getDescription();
        taskType = "Task";
        if(picked != selectedDate){
          selectedDate = widget.selectedTask.getDate();
        }
      }
      else if(widget.selectedExpense.getId() != -2){
        print("was an expense");
        descriptionController.text = widget.selectedExpense.getDescription();

        costController.text = widget.selectedExpense.getCost().toString();
        taskType = "Expense";
        if(picked != selectedDate){
          selectedDate = widget.selectedExpense.getDate();
        }
      }
      else{
        print("was a reminder");
        descriptionController.text = widget.selectedReminder.getDescription();
        taskType = "Reminder";
        if(picked != selectedDate){
          selectedDate = widget.selectedReminder.getDate();
        }
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 72),
                    child: Text('Add New Item')),
               /* Spacer(),
                IconButton(onPressed: (){
                  print("You pushed the settings button");
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SettingsPage(title: widget.title)));
                },
                    icon: Icon(Icons.view_headline_outlined))*/
              ],
            ),
            backgroundColor: Color(0xFF3C99DC),
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios_outlined),
                onPressed: () //TODO: Define a back button function, also this pops off the current screen so yes good stuff - Navigator.of(context).pop(),
                {
                  Navigator.of(context).pop();
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
                              builder: (context) => AddPage(title: widget.title, page_from: widget.page_from,isEdit: widget.isEdit, isNew: widget.isNew, selectedExpense: widget.selectedExpense, selectedTask: widget.selectedTask, selectedReminder: widget.selectedReminder,)));
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
                        margin: EdgeInsets.only(top:20, left: 15, right: 60),
                          child:
                            Text("Item Type",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              )
                            )
                      ),

                      Container(
                        margin: EdgeInsets.only(top:20, left: 15, right: 60),
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
                    margin: EdgeInsets.only(left: 15, top:25),
                    child: Text("$taskType Description",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        )
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                    //height: maxLines*24,
                    width: 350,
                    child: TextField(
                      controller: descriptionController,
                      //maxLines: maxLines,
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
                  if(taskType == 'Expense') Column(
                    children:[
                      Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(left: 15, top:25),
                      child: Text("$taskType Cost",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          )
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 13, top: 10),
                          child: Text('\$ ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20, top: 10),
                          //height: 35,
                          width: 350,
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
                      ],
                    )
                 ]),

                  //Question #3: Due date?
                  Container(
                    margin: EdgeInsets.only(top:25),
                    child: Row(
                      children: [
                        //Date Label:
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          height: 30,
                          child: Text("Due Date:  ",
                              style: TextStyle(
                                fontSize: 18,
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
                          margin: EdgeInsets.only(left: 25),
                          height: 30,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(color: CupertinoColors.darkBackgroundGray),
                              borderRadius: BorderRadius.all(Radius.circular(15))
                          ),
                          child: Text("${selectedDate.toLocal()}".split(' ')[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                color: Colors.black
                              )
                          ),
                        ),
                      ],
                    ),
                  ),


                  //Submission button:
                  Container(
                    margin: EdgeInsets.only(top:100),
                    width:100,
                    child: ElevatedButton(
                        onPressed: () => _createItem(context),
                        child: Text(
                          'Done',
                          textAlign: TextAlign.center,
                        )
                    ),
                  )

                ]
    )
        )
    ])
        //Child #1: Title - What are we adding?
    ));
  }
}
