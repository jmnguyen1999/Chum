import 'package:flutter/cupertino.dart';
class Task{

  int id;
  String description;
  DateTime dueDate;

  Task({required this.id, required this.description, required this.dueDate});

  //to be used when inserting a row in the table
  Map<String, dynamic> toMapWithoutId() {
    final map = new Map<String, dynamic>();
    map["task_description"] = description;
    map["task_due_date"] = dueDate.toString();
    return map;
  }
  //to be used when updating a row in the table
  Map<String, dynamic> toMap() {
    final map = new Map<String, dynamic>();
    map["task_id"] = id;
    map["task_description"] = description;
    map["task_due_date"] = dueDate.toString();
    return map;
  }
  //to be used when converting the row into object
  factory Task.fromMap(Map<String, dynamic> data) => new Task(
    id: data['task_id'],
    description: data['task_description'],
    dueDate: DateTime.parse(data['task_due_date']),
  );

  List<List<Task>> getTasksByDate(List<Task> listTasks){
    List<List<Task>> result = [];
    if(listTasks.isNotEmpty) {
      for (int i = 0; i < listTasks.length; i++) {
        //Assume new date --> need a new row/list:
        List<Task> newDate = <Task>[];
        newDate.add(listTasks[i]);
        DateTime dateOfItems = listTasks[i].getDate();

        //Check every other item's date + see if need to add:
        for (int j = i + 1; j < listTasks.length; j++) {
          Task otherItem = listTasks[j];
          DateTime otherDate = otherItem.getDate();

          print("date = " + dateOfItems.toString() + "  otherdate = " +
              otherDate.toString() + " i = " + i.toString() + "  j = " +
              j.toString());
          //If date is same, add this item to list, then check other items
          if (dateOfItems.compareTo(otherDate) == 0) {
            newDate.add(otherItem);
          }
          else { //otherwise, date is different, so make i jump to = j to make a new list from there
            i = j - 1;
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
    return dueDate.toString();
  }
  DateTime getDate(){
    return dueDate;
  }

}