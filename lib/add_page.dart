import 'package:chums/task_page.dart';
import 'package:flutter/material.dart';

import 'expenses_page.dart';
import 'home_page.dart';
import 'info_page.dart';
class AddPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  AddPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),

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
                            builder: (context) => HomePage(title: widget.title)));
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
                              builder: (context) => TaskPage(title: widget.title)));
                        }
                      },
                      icon: Icon(Icons.list_alt_outlined)
                  ),
                ),

                //3.) Add Icon: Add Dialog page - TODO
                Expanded(
                  child: IconButton(
                      onPressed: (){},
                      icon: Icon(Icons.add_circle_outline)
                  ),
                ),

                //4.) Money Icon: ExpensesPage - TODO: fix overflow
                Expanded(
                  child: IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => ExpensesPage(title: widget.title)));
                      },
                      icon: Icon(Icons.monetization_on_outlined)
                  ),
                ),

                //5.) Info Icon: InfoPage
                Expanded(
                  child: IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => InfoPage(title: widget.title)));
                      },
                      icon: Icon(Icons.info_outlined)
                  ),
                ),

              ],
            )
        ),
      ),
    );
  }
}
