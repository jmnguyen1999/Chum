import 'package:chum/models/items/expense.dart';
import 'package:chum/models/items/reminder.dart';
import 'package:chum/models/items/task.dart';
import 'package:chum/sqLite/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../settings/settings_page.dart';
import 'expenses_page.dart';
import '../../constants.dart' as Constants;
import 'home_page.dart';

/*
add_page.dart
Purpose:  The page displayed to create or edit items (Tasks, Reminders, or Expenses). Takes in optional items if the passed in isEdit = true. Allows partial data population if the passed
          in isNew = true. isNew = true means we have been given an empty item to populate the taskType and possible dueDate.
*/
class AddPage extends StatefulWidget {
  //Constructor --> tell us what page came from, whether or not we are editing an existing item, whether or not we are editing an empty item (isNew = true). If item not passed in --> default values used & checked during runtime.
  AddPage({Key? key, required this.title, required this.page_from, required this.isEdit, required this.isNew, selectedTask, selectedReminder,selectedExpense}) :
        //If these are null --> fill w/ invalid data to check later.
        selectedTask = selectedTask ?? Task(id:-1, description:"null", dueDate: DateTime(1999)),
        selectedReminder = selectedReminder ?? Reminder(id:-3, description:"null", dueDate: DateTime(1999)),
        selectedExpense = selectedExpense ?? Expense(id:-2, description:"null", cost:0, dueDate: DateTime(1999)),
        super(key: key);

  final String title;
  final String page_from;
  bool isEdit;
  bool isNew;                   //Flag on whether or not to pre-fill info for a new item
  Task selectedTask;
  Reminder selectedReminder;
  Expense selectedExpense;

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {

  @override
  //Purpose:  If we are starting a new item fromm specific page, populate the item type and date if needed
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
  DateTime selectedDate = DateTime.now();
  DateTime? picked = DateTime.now();

  //Controller to obtain inputs for description and cost:
  TextEditingController descriptionController = TextEditingController();
  TextEditingController costController = TextEditingController();


  //Purpose: Allows user to select a date, save selectedDate as global variable.
  Future<void> _selectDate(BuildContext context) async {
    picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    //Only change selectedDate if user has picked a new date, or there is already a date to populate because isEdit = true.
    if (widget.isEdit || (picked != null && picked != selectedDate)) {
      setState(() {
        selectedDate = picked!;
        print(selectedDate.toString());
      });
    }
  }

  //Purpose: The method called when user pushes 'Done' on the page. Creates an the correct object, inputs/updates database and returns to previous page.
  _createItem(BuildContext context) {
    bool noCostEntered = false;             //Flag to specifically check that a cost was entered if taskType = Expense.

    //1.) Only continue if there is a description --> Check which item we are creating + create it if input is valid based on isEdit
    if (descriptionController.text != "") {

      //1a.) Check what item being created
      switch (taskType) {
        case 'Task':
          //Create/update database based on if we are editing an existing item:
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
          //Create/update database based on if we are editing an existing item:
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
          //Extra validation that we have a cost inputted + is a double
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

          // Then change flag to NOT navigate to back to page_from
          else {
            noCostEntered= true;
            if(double.tryParse(costController.text) == null){
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Cost entered is not valid!')));
            }
            else{
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('Please fill out all areas.')));
            }
          }
          break;

        default:    //No default case, throw error? Show dialog.
          break;
      }


      //2.) Go back to the page came from passing along the new task, IF noCostEntered still false.
      if (!noCostEntered) {

        //Check page_from to ensure came from valid page, check using Constants class.
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

    //If description was not inputted, automatically show error + do not attempt any item creation.
    else{
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Please fill out all areas.')));
    }
  }

  //Purpose: Called automatically to build the page:
  @override
  Widget build(BuildContext context) {

    //If we are editing something, pre-fill values
    if (widget.isEdit) {

      //Check what item we are editing by checking which item does NOT have default input values
      if(widget.selectedTask.getId() != -1){
        descriptionController.text = widget.selectedTask.getDescription();
        taskType = "Task";
        if(picked != selectedDate){         //Toggle the picked variable to ensure it gets updated if user attempts to pick new date.
          selectedDate = widget.selectedTask.getDate();
        }
      }
      else if(widget.selectedExpense.getId() != -2){
        descriptionController.text = widget.selectedExpense.getDescription();

        costController.text = widget.selectedExpense.getCost().toString();
        taskType = "Expense";
        if(picked != selectedDate){
          selectedDate = widget.selectedExpense.getDate();
        }
      }
      else{
        descriptionController.text = widget.selectedReminder.getDescription();
        taskType = "Reminder";
        if(picked != selectedDate){
          selectedDate = widget.selectedReminder.getDate();
        }
      }
    }


    //Format the page:
    return Scaffold(
      resizeToAvoidBottomInset: false,

        //--------------------------------App Bar---------------------------------------
        appBar: AppBar(
            title: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 72),
                    child: Text('Add New Item')),
                Spacer(),

                //settings icon + event
                IconButton(onPressed: (){
                  print("You pushed the settings button");
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SettingsPage(title: widget.title)));
                },
                    icon: Icon(Icons.view_headline_outlined))
              ],
            ),
            backgroundColor: Color(0xFF3C99DC),

            //Back icon --> go to the page that called us.
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios_outlined),
                onPressed: ()
                {
                  Navigator.of(context).pop();
                }
            )
        ),
        backgroundColor: Color(0xFFD5F3FE),

        //Configure the bottom nav bar with same buttons + events.
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

                  //2.) Add Icon: Add Dialog page
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddPage(title: widget.title, page_from: widget.page_from,isEdit: widget.isEdit, isNew: widget.isNew, selectedExpense: widget.selectedExpense, selectedTask: widget.selectedTask, selectedReminder: widget.selectedReminder,)));
                        },
                        icon: Icon(Icons.add_circle_outline, color: Colors.white)
                    ),
                  ),

                  //3.) Money Icon: ExpensesPage -
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
        //Background color gradient:
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
          Expanded(
            child: SingleChildScrollView(
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

                          //Divider line
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: Divider(
                                height: 1,
                                thickness: 1,
                                indent:0,
                                endIndent:0,
                                color: Color(0xFF0F5298)
                            ),
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
                          //Divider line
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Divider(
                                height: 1,
                                thickness: 1,
                                indent:0,
                                endIndent:0,
                                color: Color(0xFF0F5298)
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
                              ]),
                              //Divider line
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Divider(
                                    height: 1,
                                    thickness: 1,
                                    indent:0,
                                    endIndent:0,
                                    color: Color(0xFF0F5298)
                                ),
                              ),
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
                          //Divider line
                          Container(
                            margin: EdgeInsets.only(top: 25),
                            child: Divider(
                                height: 1,
                                thickness: 1,
                                indent:0,
                                endIndent:0,
                                color: Color(0xFF0F5298)
                            ),
                          ),

                          //Submission button:
                          Container(
                            margin: EdgeInsets.only(top:40),
                            width:100,
                            child: ElevatedButton(
                                onPressed: () => _createItem(context),
                                child: Text(
                                  'Done',
                                  textAlign: TextAlign.center,
                                )
                            ),
                          )

                        ],
                  ),
              )
        ),
    ])
        //Child #1: Title - What are we adding?
    ));
  }
}
