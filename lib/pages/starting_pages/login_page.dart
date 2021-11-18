
import 'package:chums/pages/starting_pages/create_account_page.dart';
import 'package:chums/pages/starting_pages/user_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../bottom_navigation/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(title: 'Chums'),
    );
  }
}

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _counter = 0;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();


  logIn(BuildContext context){
    String username = usernameController.text;
    String pass = passController.text;

    print("login page sending username: " + username);
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => UserHomePage(title: widget.title, usernameSignedIn: usernameController.text,)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
      //  title: Text(widget.title),
      //),
      backgroundColor: Color(0xFFFFFFFF),
     /* bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(height: 50.0,)
      ),*/
      body: Center(
        child:
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFFFFFFF),
                  Color(0xFFD5F3FE),
                  Color(0xFF66D3FA),
                  Color(0xFF3C99DC),
                  //Color(0xFF2565AE),
                ],
              )
          ),
          child: Center(
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 50,
                  child: Container(
                      margin: EdgeInsets.only(),
                      child:
                      Image.asset('assets/circle_logo_2.png')
                  ),
                ),
                /*Text(
              'Sign In',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            ),*/
                Expanded(
                  flex: 10,
                  child:
                        Container(
                          margin: EdgeInsets.only(left:25, right: 25),
                          child: TextField(
                            obscureText: false,
                                      controller: usernameController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              labelText: 'Username/Email',
                            ),
                          ),
                        ),
                ),
                Expanded(
                  flex: 10,
                  child: Container(
                    margin: EdgeInsets.only(left:25, right: 25),
                    child: TextField(
                      obscureText: false,
                      controller: passController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                ),
                Expanded(
                    flex: 20,
                  child:
                  Container(
                    margin: EdgeInsets.only(top:40, bottom:40),
                    child: ElevatedButton(
                        onPressed: (){
                          logIn(context);
                        },
                        child: Text('Sign In')
                    ),
                  )
                ),
                Expanded(
                  flex: 10,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Color(0xFF2565AE)
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreateAccountPage(title: widget.title)));
                    },
                    child: const Text('Don\'t have an account? Sign up here!'),
                  ),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
