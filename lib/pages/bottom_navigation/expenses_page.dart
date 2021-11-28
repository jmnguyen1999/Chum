
import 'package:chum/models/items/expense.dart';
import 'package:chum/sqLite/database.dart';
import 'package:flutter/material.dart';

import 'add_page.dart';
import 'home_page.dart';
import '../../constants.dart' as Constants;


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
    // TODO: implement initState
    getExpenses();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_EXPENSES, isEdit:false)));
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
                                    'Your Expenses...',
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Lato',
                                    ),
                                  ),
                                ),
                              ]
                          ),


                          //Child #3: Whole bulk of page:
                          Column(
                              children: [

                                //Child #3a: Announcements - Column
                                Column(
                                    children: [
                                      //Announcement Label:
                                      Row(
                                        children: [
                                          Spacer(),
                                          Container(
                                            alignment: Alignment.topRight,
                                            margin: EdgeInsets.only(right: 8, top: 10),
                                            child: IconButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_EXPENSES, isEdit:false)));
                                                },
                                                icon: Icon(Icons.add_circle_outline)
                                            ),
                                          ),
                                        ],
                                      ),

                                      //Announcement Data:
                                      Container(
                                          width: 370,
                                          height: 450,
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
                                                return Dismissible(
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
                                                                  Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.only(bottom: 5),
                                                                        child: Text(
                                                                            '${expenses[index].getDescription()}',
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
                                                );
                                              })

                                      ),
                                    ]
                                ),


                                //End of additional commented out


                              ]
                          )
                        ]
                    )
                )
            )));
  }
}



//End of Paste!!!!!!!!!!!!!!!!!!



    //What I'm commenting out:
   /* return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        backgroundColor: Color(0xFFDBF0E9),
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
                      color: Colors.white,
                      width: 400,
                      alignment: Alignment.center,
                      child: Text(
                          'Your Master List',
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
                                    child: Text('Reminders:',
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
                                        color: Colors.white,
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
                                        child: Text('Regular Expenses to Buy:',
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
                                            color: Colors.white,
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
                                                Text('Unique Expenses to Buy:',
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
                                                    color: Colors.white,
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
                  )
                ])
        )
    );
  }
}
*/