
import 'package:chums/models/circle.dart';
import 'package:chums/models/item.dart';
import 'package:chums/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_page.dart';

class UserHomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  UserHomePage({Key? key, required this.title, required this.whichUserSignIn}) : super(key: key);
  final String title;
  int whichUserSignIn;

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  TextEditingController roomCodeController = TextEditingController();


  //Purpose: For now lol, determine which Circle to initialize and join as examples for demo
  joinCircle(BuildContext context){
    String roomCode = roomCodeController.text;
    print("roomCode entered = " + roomCode);
  print("userSignIn received = " + widget.whichUserSignIn.toString());
    //Figure out which user we signed in as for example sake:
    User user = User("", "", "", "", "", null);

    switch(widget.whichUserSignIn){
      case 1:
        user = User("jmnguyen", "pass", "email", "Jo", "Nguyen", null);
        break;
      case 2:
        user = User("pon23", "pass", "email", "Po", "Lam", null);
        break;
      default:
        print("user_home: userSign in is wrong dummy");
    }
    print("user_home page initialized us = " + user.getFName());

    List<User> members = <User>[
      user
    ];
    List<Item> tasks = <Item>[];
    List<Item> announcements = <Item>[];
    List<Item> reminders = <Item>[];
    List<Item> expenses = <Item>[];
    User host = User("", "", "", "", "", null);
    String circleName = "";
    Circle myCircle = Circle(members, host, circleName, null, null, null, null);


    switch(roomCode){
      case "FWET":
        //Tasks:
        tasks.add(Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
        tasks.add(Item(1, 'Take out trash', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
            tasks.add(Item(1, 'someething here', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
        tasks.add(Item(1, 'Something therre', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 9)));
        tasks.add(Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 10)));
            tasks.add(Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 10)));


        //Announcements:
        announcements.add(Item(2, 'Meeting for HW #2, CS 4310', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 10, 11)));
        announcements.add(Item(2, 'Martha\'s family visiting', User("loluser", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 10, 11)));
        announcements.add(Item(2, 'Water filter broken, we need to find another', User("heyBob", "pass", "email", "Po", "Lam", null), null, null));

        //Reminders:

        //Expenses:

        myCircle = Circle(members, host, circleName, tasks, announcements, expenses, reminders);
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => HomePage(title: widget.title, circle: myCircle)));
        break;

      case "LOKI":
        break;
      case "PNTO":
        break;
      default:
        print("You didn't enter one of your 3 roomcodes stupid");
        break;
    }



  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     /* appBar: AppBar(
        title: Text(widget.title),
      ),*/
      backgroundColor: Color(0xFF3C99DC),
      body: Center(
        child: Column(
          children: [
            Container(
              width: 175,
              height: 175,
              decoration: BoxDecoration(
                  border: Border.all(width: 0.5),
                  borderRadius: new BorderRadius.circular(30.0),
                  color: Colors.white
              ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('Join a Circle?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30
                    ),)
                ],
              ),
            ),

            TextField(
              obscureText: false,
              controller: roomCodeController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                labelText: 'Enter a Room Code',
              ),
            ),
            ElevatedButton(
                onPressed: (){
                  joinCircle(context);
                },
                child: Text('Your Circles')
            ),

          ],
        ),
      ),


    );
  }

}