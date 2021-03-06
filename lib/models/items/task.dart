
import 'package:intl/intl.dart';

/*
  task.dart
  Purpose:                Model class to encapsulate all data regarding a Task item. A Task item is an item to display with a description and due date.
  Correlated File:        Used with add_page.dart, home_page.dart, database.dart
 */
class Task{

  int id;
  String description;
  DateTime dueDate;
  bool isDone;          //Only used to toggle checkboxes in expenses_page.dart

  //Purpose:  Constructor, isDone optional w/default values
  Task({required this.id, required this.description, required this.dueDate, isDone}):
      isDone = false;

  //------------For Database interaction--------------------------------
  //Purpose:  to be used when inserting a row in the database table, creates a database row from a Task object without an actual valid id. (b/c has yet to be in database)
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["task_description"] = description;
    map["task_due_date"] = dueDate.toString();
    return map;
  }

  //Purpose:  to be used to convert a Task object into a row in the database
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["task_id"] = id;
    map["task_description"] = description;
    map["task_due_date"] = dueDate.toString();
    return map;
  }

  //Purpose: to be used when converting a given database row into a Task object
  factory Task.fromMap(Map<String, dynamic> data) => new Task(
    id: data['task_id'],
    description: data['task_description'],
    dueDate: DateTime.parse(data['task_due_date']),
  );

  //Purpose:  Orders given List<Task> into a 2d List by date. Closest date --> latest date. Utilized by home_page.dart to format Tasks correctly.
  List<List<Task>> getTasksByDate(List<Task> listTasks){
    List<List<Task>> result = [];
    if(listTasks.isNotEmpty) {
      for (int i = 0; i < listTasks.length; i++) {
        //Assume new date --> need a new row/list:
        List<Task> newDate = <Task>[];
        newDate.add(listTasks[i]);
        String dateOfItems = listTasks[i].getDateString();

        //Check every other item's date + see if need to add:
        for (int j = i + 1; j < listTasks.length; j++) {
          Task otherItem = listTasks[j];
          i = j-1;
          //If date is same, add this item to list, then check other items
          if (dateOfItems == otherItem.getDateString()){//(dateOfItems.compareTo(otherDate) == 0) {
            newDate.add(otherItem);
            //If the last one item was a copy, we can skip to the end of the list since we just configured the last item anyway
            if(i == listTasks.length-2){
              i = listTasks.length;
            }
          }
          else { //otherwise, date is different, so make i jump to = j to make a new list from there
            break;
          }
        }
        //Add this new list to the 2d list:
        result.add(newDate);
      }
    }
    return result;
  }




  //Getter methods:
  int getId(){
    return id;
  }
  bool getIsDone(){
    return isDone;
  }
  String getDescription(){
    return description;
  }
  bool hasDueDate(){
    return !(dueDate.compareTo(DateTime(1999)) == 0);
  }
  String getDateString(){
    if(!hasDueDate()){
      return "N/A";
    }
    return DateFormat('EEEE, MMMM d').format(dueDate);
  }
  DateTime getDate(){
    return dueDate;
  }

}