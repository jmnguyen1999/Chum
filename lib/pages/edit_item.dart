import 'package:chums/models/circle.dart';
import 'package:chums/models/item.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation/add_page.dart';
import 'bottom_navigation/expenses_page.dart';
import 'bottom_navigation/home_page.dart';
import 'bottom_navigation/info_page.dart';
import 'bottom_navigation/task_page.dart';
import '../../constants.dart' as Constants;

class EditItemPage extends StatefulWidget {
 // const EditItemPage({Key? key}) : super(key: key);
  EditItemPage({Key? key, required this.title, required this.circle, required this.item}) : super(key: key);
  final String title;
  Circle circle;
  Item item;

  @override
  _EditItemPageState createState() => _EditItemPageState();
}

class _EditItemPageState extends State<EditItemPage> {
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
    ))
    );
  }
}
