import 'package:chums/models/user.dart';

class Item{
  int type; //(1) = Task, (2) = Announcement, (3) = Reminder, (4) = Expense
  String description;
  User author;
  DateTime dueDate;
  List<User> membersAssigned;   //Whos responsibility is it?
//TODO: Separate into different types I think? B/c tasks need a isDone

  Item(this.type, this.description, this.author, membersAssigned, dueDate,
    /*{
      List<User>? membersAssigned,  //Nullable
      DateTime? dueDate
    }*/) :
    membersAssigned = membersAssigned ?? [],
    dueDate = dueDate ?? DateTime(1999);


  //Getter methods:
  User getAuthor(){
    return author;
  }
  String getDescription(){
    return description;
  }
  bool hasDueDate(){
    return !(dueDate.compareTo(DateTime(1999)) == 0);
  }
  int getType(){
    return type;
  }
  List<User> getMembersAssigned(){
    return membersAssigned;
  }
  String getDateString(){
    if(!hasDueDate()){
      return "N/A";
    }
    return dueDate.toString();
  }
  DateTime getDate(){
    return dueDate;
  }

}