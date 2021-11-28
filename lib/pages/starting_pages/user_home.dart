/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../bottom_navigation/home_page.dart';


class UserHomePage extends StatefulWidget {
  //const HomePage({Key? key}) : super(key: key);
  UserHomePage({Key? key, required this.title, required this.usernameSignedIn}) : super(key: key);
  final String title;
  final String usernameSignedIn;

  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  TextEditingController roomCodeController = TextEditingController();

  hostCircle(BuildContext context){

    Constants constants = Constants();
    User user = constants.getCorrectUser(widget.usernameSignedIn);
    Circle circle = constants.getEmptyCircle();
    circle.addMember(user);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomePage(title: widget.title, circle: circle)));
  }


  //Purpose: For now lol, determine which Circle to initialize and join as examples for demo
  joinCircle(BuildContext context){
    String roomCode = roomCodeController.text;
    print("roomCode entered = " + roomCode);
    print("username received = " + widget.usernameSignedIn.toString());

    Constants constants = Constants();
    User user = constants.getCorrectUser(widget.usernameSignedIn);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => HomePage(title: widget.title, circle: constants.getCorrectCircle(roomCode, user))));
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
     */
/* appBar: AppBar(
        title: Text(widget.title),
      ),*//*

      backgroundColor: Color(0xFF3C99DC),
      body: Container(
      decoration: BoxDecoration(
      gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
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
        child: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                width: 150,
                height: 150,
                margin: EdgeInsets.only(top: 10, bottom: 65),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.5,
                      color: Color(0xFF2565AE)
                    ),
                    borderRadius: new BorderRadius.circular(55.0),
                    color: Colors.white
                ),
                alignment: Alignment.center,
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Join a Circle!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Color(0xFF0F5298)
                      ),)
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(left:25, right:25, bottom: 75),
                child: TextField(
                  obscureText: false,
                  controller: roomCodeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: 'Enter a Room Code',

                  ),
                ),
              ),
              Container(
                width: 130,
                height: 35,
                child: ElevatedButton(
                    onPressed: (){
                      joinCircle(context);
                    },
                    child: Text('Join',
                    )
                ),
              ),

              Container(
                width: 130,
                height: 35,
                margin: EdgeInsets.only(top: 25),
                child: ElevatedButton(
                    onPressed: (){
                      hostCircle(context);
                    },
                    child: Text('Host a Circle!',
                      textAlign: TextAlign.center,
                    )
                ),
              ),

            ],
          ),
        ),
      ),


    )
    );
  }

}*/
