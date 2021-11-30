
import 'package:flutter/material.dart';

/*
import 'bottom_navigation/add_page.dart';
import 'bottom_navigation/expenses_page.dart';
import 'bottom_navigation/main.dart';
import '../../constants.dart' as Constants;

class EditItemPage extends StatefulWidget {
 // const EditItemPage({Key? key}) : super(key: key);
  EditItemPage({Key? key, required this.title,required this.item, required this.page_from}) : super(key: key);
  final String title;
  Item item;
  String page_from;

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
  String dropdownValue = 'One';
  var items =  ['Apple','Banana','Grapes','Orange','watermelon','Pineapple'];

  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation = ""; // Option 2

  //Values to store to create new Item:
  String assignedChum = "";
  String taskType = 'Task';
  String assignedRole = "";
  String description = "";

  TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  List<String> chumNames = <String>['One', 'Two', 'Free', 'Four'];
  List<String> roles = <String>[];

  @override
  void initState() {
    //Initialize chumNames and roles
    chumNames = widget.circle.getMemberNames();
    chumNames.insert(0, "None");

    print("chumNames: ");
    for(String name in chumNames){
      print(name);
    }

    roles.insert(0, "None");
    for(int i = 1; i <= widget.circle.getRoles().length; i++){
      roles.insert(i, "Role #"+ i.toString());
    }

    print("roles: ");
    for(String name in roles){
      print(name);
    }

    assignedChum = chumNames[0];
    assignedRole = roles[0];
    super.initState();
  }

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
  _finishItem(BuildContext context){
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

    //2.) Go back to the page came from passing along the new task
    //Should prob not put this here buut you know - Make sure page_from is valid page --> go to that page with updated list.
    switch(widget.page_from){
      case Constants.KEY_HOME:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomePage(title: widget.title, circle: widget.circle,)));
        break;
      case Constants.KEY_TASKS:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => TaskPage(title: widget.title, circle: widget.circle,)));
        break;
      case Constants.KEY_EXPENSES:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ExpensesPage(title: widget.title, circle: widget.circle,)));
        break;
      case Constants.KEY_INFO:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => InfoPage(title: widget.title, circle: widget.circle,)));
        break;
      case Constants.KEY_ADD:
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddPage(title: widget.title, circle: widget.circle, page_from: widget.page_from)));
        break;
      default:
        print("add_page:  page_from was not valid, so did not navigate back from anywhere");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
          title: Row(
            children: [
              Container(
                  margin: EdgeInsets.only(left: 72),
                  child: Text('Edit Task')),
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
                            builder: (context) => AddPage(title: widget.title, circle: widget.circle, page_from: Constants.KEY_EDIT_PAGE,)));
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

                          */
/*
                  //Title:
                  Text("Add new item",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )
                  ),
*//*



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
                                  items: <String>['Task', 'Announcement', 'Reminder', 'Expense']
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
                                        fontWeight: FontWeight.bold,
                                      )
                                  ),
                                ),

                                //Dropdown of possible chums:
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: DropdownButton(
                                    value: assignedChum,
                                    icon: const Icon(Icons.arrow_downward),
                                    iconSize: 24,
                                    elevation: 16,
                                    style: const TextStyle(color: Color(0xFF0F5298)),
                                    underline: Container(
                                      height: 2,
                                      color: Color(0xFF2565AE),
                                    ),
                                    onChanged: (String? newChum) {
                                      setState(() {
                                        assignedChum = newChum!;
                                      });
                                    },
                                    items: chumNames.map((String value) {
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
                                        fontWeight: FontWeight.bold,
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
                                    style: const TextStyle(color: Color(0xFF0F5298)),
                                    underline: Container(
                                      height: 2,
                                      color: Color(0xFF2565AE),
                                    ),
                                    onChanged: (newRole) {
                                      setState(() {
                                        assignedRole = newRole!;
                                      });
                                    },
                                    items: roles.map((String value) {
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
                              onPressed: () => _finishItem(context),
                              child: Text(
                                'Done',
                                textAlign: TextAlign.center,
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
