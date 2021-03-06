import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart' as Constants;
import '../bottom_navigation/add_page.dart';
import '../bottom_navigation/expenses_page.dart';
import '../bottom_navigation/home_page.dart';
import 'about_page.dart';
import 'help_page.dart';

/*
settings_page.dart
Purpose:      Configures the settings page, links to the help_page and about_page. This page can be accessed from the app bar from any screen.

 */
class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        //-------------------------App bar---------------------------
        appBar: AppBar(
            title: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(left: 98),
                    child: Text('Settings')
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

        //------------------------Bottom nav bar-----------------------------------
        bottomNavigationBar: Container(
          height: 50,
          child: BottomAppBar(
              color: Color(0xFF0F5298),
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
                        icon: Icon(Icons.home, color: Colors.white)
                    ),
                  ),

                  //2.) Add Icon: Add Dialog page - TODO
                  Expanded(
                    child: IconButton(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AddPage(title: widget.title, page_from: Constants.KEY_INFO, isEdit: false, isNew:false)));
                        },
                        icon: Icon(Icons.add_circle_outline, color: Colors.white)
                    ),
                  ),

                  //3.) Money Icon: ExpensesPage - TODO: fix overflow
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
                  SingleChildScrollView(
                      child: Column(
                          children: [
                            //For General Option:
                            Container(
                                margin: EdgeInsets.only(left: 30, right: 30, top: 20),
                                child: Column(
                                    children: [
                                      Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 20, bottom:11),
                                              width: 30,
                                              height: 30,
                                              child: IconButton(
                                                icon: Icon(Icons.info_outlined),
                                                onPressed: () {  },
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  //margin: EdgeInsets.only(bottom: 5),
                                                  child: Text(
                                                      'Help',
                                                      style: TextStyle(
                                                          fontSize:16
                                                      )
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            IconButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) => HelpPage(title: widget.title)));
                                                },
                                                icon: Icon(Icons.arrow_forward_ios)
                                            )
                                          ]
                                      ),

                                      Container(
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


                            //For Roles option:
                            Container(
                                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                                child: Column(
                                    children: [
                                      Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(right: 20, bottom: 11, ),
                                              width: 30,
                                              height: 30,
                                              child:  IconButton(
                                                icon: Icon(Icons.wb_incandescent_outlined)/*Icon(Icons.group)*/,
                                                onPressed: () {  },
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  //margin: EdgeInsets.only(bottom: 5),
                                                  child: Text(
                                                      'About',
                                                      style: TextStyle(
                                                          fontSize:16
                                                      )
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            IconButton(
                                                onPressed: (){
                                                  Navigator.push(context, MaterialPageRoute(
                                                      builder: (context) => AboutPage(title: widget.title)));
                                                },
                                                icon: Icon(Icons.arrow_forward_ios)
                                            )
                                          ]
                                      ),

                                      Container(
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

                            //For Leave Group Option:
                           /* Container(
                                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
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
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  //margin: EdgeInsets.only(bottom: 5),
                                                  child: Text(
                                                      'Leave Group?',
                                                      style: TextStyle(
                                                          fontSize:16,
                                                          fontWeight: FontWeight.bold,
                                                          color: Colors.red
                                                      )
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ]
                                      ),

                                      Container(
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
                            ),*/
                          ]
                      )
                  )
                ])));
  }
}
