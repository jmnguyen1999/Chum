import 'package:chum/pages/bottom_navigation/add_page.dart';
import 'package:chum/pages/bottom_navigation/expenses_page.dart';
import 'package:chum/pages/bottom_navigation/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart' as Constants;
class HelpPage extends StatefulWidget {
  //const HelpPage({Key? key}) : super(key: key);

  HelpPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
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
                    child: Text('Help')
                ),
              ],
            ),
            backgroundColor: Color(0xFF3C99DC),
            leading: new IconButton(
                icon: new Icon(Icons.arrow_back_ios_outlined),
                onPressed: ()
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
                              Container(
                                      alignment: Alignment.topLeft,
                                      margin: EdgeInsets.only(left: 20, top: 30, bottom: 20),
                                      child: Text(
                                        'How do I use Chum?',
                                        style: TextStyle(
                                          fontSize: 27,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Lato',
                                        ),
                                      ),
                                    ),
/*
",
 */
                              Container(
                                  width: 370,

                                  decoration: BoxDecoration(
                                      color: Colors.white38,
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  ),
                                  child:
                                  Column(
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(left:25, right: 25, top: 20),
                                          alignment: Alignment.topLeft,
                                          child: Text("Add Items:",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                fontWeight: FontWeight.bold
                                              )
                                          )
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                                          child: Text("Add all of your To-do items including your daily tasks, reminders, and expenses! You can add any item from any + icon in the app. Just fill out the form, then press 'Done'.",
                                              style: TextStyle(
                                              fontSize: 16
                                            )
                                          )
                                      ),

                                      //Complete tasks section
                                      Container(
                                          margin: EdgeInsets.only(left:25, right: 25, top: 20),
                                          alignment: Alignment.topLeft,
                                          child: Text("Delete Items:",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              )
                                          )
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                                          child: Text("Completed your tasks and need to clear them for the day? Swipe right or left on any item to clear it! Be careful though, this action cannot be undone!\n\n What if youinished a task but aren't sure if you want clear it? Utilize the checkboxes to keep track of the items you've done so far!",
                                              style: TextStyle(
                                                  fontSize: 16
                                              )
                                          )
                                      ),

                                      //Edit items section
                                      Container(
                                          margin: EdgeInsets.only(left:25, right: 25, top: 20),
                                          alignment: Alignment.topLeft,
                                          child: Text("Edit Items:",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              )
                                          )
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                                          child: Text("Messed up when you created an item? Or did an item change last minute? No worries! Just click on the item to be taken back to the edit page and change its details!",
                                              style: TextStyle(
                                                  fontSize: 16
                                              )
                                          )
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                                          child: Text("\n\nThat's pretty much it, there's no right way to use Chum, just use it to however you need with whatever you need!\n",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontStyle: FontStyle.italic
                                              )
                                          )
                                      )
                                    ],
                                  )
                              ),
                            ]
                        ),
                    ),
                  )]
            )));
  }
}

