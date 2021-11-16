import 'package:chums/task_page.dart';
import 'package:flutter/material.dart';

import 'add_page.dart';
import 'expenses_page.dart';
import 'home_page.dart';
import 'models/circle.dart';
class InfoPage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  InfoPage({Key? key, required this.title, required this.circle}) : super(key: key);
  final String title;
  Circle circle;
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
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
    );
  }
}
