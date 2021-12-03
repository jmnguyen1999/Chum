import 'package:chum/pages/bottom_navigation/add_page.dart';
import 'package:chum/pages/bottom_navigation/expenses_page.dart';
import 'package:chum/pages/bottom_navigation/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../constants.dart' as Constants;

/*
about_page.dart
Purpose:      Displays information about About. What's next for Chum, what is it? No actual functionality other than displaying Strings. Linked to settings_page
 */
class AboutPage extends StatefulWidget {
  AboutPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 98),
                    child: Text('About')
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
                                'What is Chum?',
                                style: TextStyle(
                                  fontSize: 25,
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
                                        margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                                        child: Text("Chum is a daily task organizer app that aids users in visualizing their tasks, reminders, and expenses all in one place! Chum was intended to help boost your productiviity and allow you to hold yourself accountable to your everyday responsibilities!\n",
                                            style: TextStyle(
                                                fontSize: 16
                                            )
                                        )
                                    ),
                                  ],
                                )
                            ),


                            //What's next for Chum:
                            //Child #1: Title - What are we adding?
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(left: 20, top: 30, bottom: 20),
                              child: Text(
                                'What\'s next for Chum?',
                                style: TextStyle(
                                  fontSize: 25,
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
                                    //Edit items section
                                    Container(
                                        margin: EdgeInsets.only(left:25, right: 25, top: 20),
                                        alignment: Alignment.topLeft,
                                        child: Text("Alarms:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                                        child: Text("We\'re currently working on integrating an alarm reminder system so that Chum can better help keep you accountable! The idea is to set alarms automatically on your phone to remind you in advance what you need to do and when. Keep on the lookout for the next update!\n",
                                            style: TextStyle(
                                                fontSize: 16
                                            )
                                        )
                                    ),

                                    //Settings section
                                    Container(
                                        margin: EdgeInsets.only(left:25, right: 25, top: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text("Settings:",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                                        child: Text("We want to provide a more personal experience than what Chum is currently offering. Expect to be able to adjust your own personal settings to the look, organization, and filter of Chum!\n",
                                            style: TextStyle(
                                                fontSize: 16
                                            )
                                        )
                                    ),
                                    //Edit items section
                                    Container(
                                        margin: EdgeInsets.only(left:25, right: 25, top: 10),
                                        alignment: Alignment.topLeft,
                                        child: Text("Chums!",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold
                                            )
                                        )
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(left: 25, right: 25, top: 15),
                                        child: Text("Chum is also soon looking to expand to Chums! Chum originally is an individual app looking to aid one person in organizing their tasks, however, Chums is looking to help groups of people plan and design their tasks as a group! More details will come soon!\n",
                                            style: TextStyle(
                                                fontSize: 16
                                            )
                                        )
                                    ),
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

