import 'models/circle.dart';
import 'models/item.dart';
import 'models/user.dart';

const String KEY_HOME = "home_page";
const String KEY_TASKS = "task_page";
const String KEY_EXPENSES = "expenses_page";
const String KEY_INFO = "info_page";
const String KEY_ADD = "add_page";

//All example data to mock me database lol:
class Constants {

  Constants();

  //All User Accounts:
  User me = User("jmnguyen", "pass", "email", "Jo", "Nguyen", null);
  User user2 = User("pon23", "pass", "email", "Po", "Lam", null);

  User getCorrectUser(String username){
    switch(username){
      case "jmnguyen":
        return User("jmnguyen", "pass", "email", "Jo", "Nguyen", null);
        break;
      case "pon23":
        return User("pon23", "pass", "email", "Po", "Lam", null);
        break;
      default:
        print("user_home: userSign in is wrong dummy");
        return getEmptyUser();
    }
  }
  Circle getCorrectCircle(String roomCode, User user){
    List<User> members = <User>[user];
    List<Item> tasks = <Item>[];
    List<Item> announcements = <Item>[];
    List<Item> reminders = <Item>[];
    List<Item> expenses = <Item>[];
    User host = User("", "", "", "", "", null);
    String circleName = "";

    switch(roomCode){
      case "FWET":
      //Tasks:
        tasks.add(Item(1, 'Buy tissue paper', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
        tasks.add(Item(1, 'Take out trash', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
        tasks.add(Item(1, 'someething here', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
        tasks.add(Item(1, 'something to do on the 9th', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 9)));
        tasks.add(Item(1, 'on 10th i like food make food', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 10)));
        tasks.add(Item(1, 'on 10th i do something else', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 10)));


        //Announcements:
        announcements.add(Item(2, 'Meeting for HW #2, CS 4310', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 10, 11)));
        announcements.add(Item(2, 'Martha\'s family visiting', User("loluser", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 10, 11)));
        announcements.add(Item(2, 'Water filter broken, we need to find another', User("heyBob", "pass", "email", "Po", "Lam", null), null, null));

        //Reminders:

        //Expenses:
        expenses.add(Item(4, 'Fruits - bananas, mandarins, and pineapple', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
        expenses.add(Item(4, 'Car engine light bill', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
        expenses.add(Item(4, 'pay Almira \$14 for dinner!!', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 8)));
        expenses.add(Item(4, 'white t-shirts for work, 5-pack+', User("heyBob", "pass", "email", "Po", "Lam", null), null, DateTime(2021, 9, 9)));

        //TODO: Add more members
        return Circle(members, host, circleName, tasks, announcements, expenses, reminders);
      /*case "LOKI":
        break;
      case "PNTO":
        break;*/
      default:
        print("You didn't enter one of your 3 roomcodes stupid");
        return getEmptyCircle();
        break;
    }
  }


  List<Item> getEmptyItems(){
    return <Item>[];
  }
  User getEmptyUser(){
    return User("", "", "", "", "", null);
  }
  List<User> getEmptyUsers(){
    return <User>[];
  }
  Circle getEmptyCircle(){
    return Circle(
        getEmptyUsers(),
        getEmptyUser(),
        "",
        getEmptyItems(),
        getEmptyItems(),
        getEmptyItems(),
        getEmptyItems());
  }
}