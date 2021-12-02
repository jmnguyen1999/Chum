
import 'package:chum/models/items/expense.dart';
import 'package:chum/models/items/reminder.dart';
import 'package:chum/sqLite/database.dart';
import 'package:flutter/material.dart';

import '../settings/settings_page.dart';
import 'add_page.dart';
import '../../main.dart';
import '../../constants.dart' as Constants;
import 'home_page.dart';


class ExpensesPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  ExpensesPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _ExpensesPageState createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {

  List<Expense> expenses = <Expense>[];

  void getExpenses() async {
    List<Map<String, dynamic>> listMap = await DatabaseHelper.instance.queryAllExpenses();
    setState(() {
      listMap.forEach((map) => expenses.add(Expense.fromMap(map)));
      print("expenses from getExpense(): " + expenses.toString());
    });
  }
  @override
  void initState() {
    getExpenses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
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
                    margin: EdgeInsets.only(left: 98),
                    child: Text('Expenses')
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
                              builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_EXPENSES, isEdit:false, isNew:false)));
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
                            //Child #1: Title - What are we adding?
                            Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 20, top: 15),
                                    child: Text(
                                      'Your Expenses...',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Lato',
                                      ),
                                    ),
                                  ),
                                Spacer(),
                                Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 8, top: 25),
                                  child: IconButton(
                                      onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(
                                            builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_HOME, isEdit: false, isNew:true, selectedExpense: new Expense(id:0, description:"", cost: -1, dueDate:null),)));
                                      },
                                      icon: Icon(Icons.add_circle_outline)
                                  ),
                                ),
                            ]),


                            //Child #3: Whole bulk of page:
                            Column(
                                children: [

                                  //Child #3a: Expenses - Column
                                  Column(
                                      children: [
                                        //Expenses data
                                        Container(
                                            width: 370,
                                     //       height: 450,
                                            decoration: BoxDecoration(
                                                color: Colors.white38,
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child:
                                            //List based on announcements
                                            ListView.builder(
                                                primary: false,
                                                shrinkWrap: true,
                                                itemCount: expenses.length,
                                                itemBuilder: (BuildContext context, int index){
                                                  final expense = expenses[index].getDescription();
                                                  return ListTile(
                                                    onTap: (){
                                                      print("ListTile tapped from homepage, sending task: " + expenses[index].getDescription());
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_HOME, isEdit:true, isNew:false, selectedExpense:expenses[index])));
                                                    },
                                                    title: Dismissible(
                                                      key: UniqueKey(),
                                                      onDismissed: (direction) {
                                                        print("reminder id to delete: " + expenses[index].getId().toString());
                                                        DatabaseHelper.instance.deleteExpense(expenses[index].getId());
                                                        setState(() {
                                                          expenses.removeAt(index);
                                                        });
                                                        // Then show a snackbar.
                                                        ScaffoldMessenger.of(context)
                                                            .showSnackBar(SnackBar(content: Text('$expense deleted')));
                                                      },
                                                      background: Container(color: Color(0xFF2565AE)),
                                                      child: Container(
                                                          margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                                                          child: Column(
                                                              children: [
                                                                Row(
                                                                    children: [
                                                                      Checkbox(
                                                                        checkColor: Colors.white,
                                                                        fillColor: MaterialStateProperty.resolveWith(getColor),
                                                                        value: expenses[index].getIsDone(),
                                                                        onChanged: (bool? value) {
                                                                          setState(() {
                                                                            expenses[index].isDone = value!;
                                                                          });
                                                                        },
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Container(
                                                                            margin: EdgeInsets.only(bottom: 5),
                                                                            child: Text(
                                                                                '\$${expenses[index].getCost().toString()} - ${expenses[index].getDescription()}',
                                                                                style: TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                    fontSize:14
                                                                                )
                                                                            ),
                                                                          ),
                                                                          Text('Due date: ${expenses[index].getDateString()}',
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
                                                      ),
                                                    ),
                                                  );
                                                })

                                        ),
                                      ]
                                  ),
                                ]
                            )
                          ]
                      )
                  ),
                )]
            )));
  }
}